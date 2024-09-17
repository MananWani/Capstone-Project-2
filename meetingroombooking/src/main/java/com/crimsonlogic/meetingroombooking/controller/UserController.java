package com.crimsonlogic.meetingroombooking.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.crimsonlogic.meetingroombooking.dto.FilteredDataDto;
import com.crimsonlogic.meetingroombooking.dto.UsersDto;
import com.crimsonlogic.meetingroombooking.entity.Users;
import com.crimsonlogic.meetingroombooking.exception.UserExistsException;
import com.crimsonlogic.meetingroombooking.service.UsersService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author abdulmanan
 *
 */
@Controller
@RequestMapping("/user")
public class UserController {

	private static final String LOGIN = "login";

	@Autowired
	UsersService usersService;

	/**
	 * Displays the registration form with empty user object and lists of
	 * designations and managers.
	 * 
	 * @param model The model to pass attributes to the view.
	 * @return The name of the JSP file to display.
	 */
	@GetMapping("/register")
	public String showRegisterForm(Model model) {
		model.addAttribute("user", new Users());
		model.addAttribute("designationList", usersService.getdesignations());
		model.addAttribute("managerList", usersService.getUsersWithManagerDesignations());
		return "register";
	}

	/**
	 * Handles the registration of a new user. On success, redirects to the list of
	 * users. On failure, returns to the registration form with an error message.
	 * 
	 * @param usersDto The DTO containing user details to be registered.
	 * @param model    The model to pass attributes to the view.
	 * @return Redirect URL or view name based on the outcome of the registration.
	 */
	@PostMapping("/register")
	public String registerUser(@ModelAttribute UsersDto usersDto, Model model) {
		try {
			usersService.addUser(usersDto);
			return "redirect:/user/getallusers?userAdded=User added successfully!";
		} catch (UserExistsException e) {
			model.addAttribute("alreadyExists", e.getMessage());
			return "register";
		}
	}

	/**
	 * Displays the login form with an empty user object.
	 * 
	 * @param model The model to pass attributes to the view.
	 * @return The name of the JSP file to display.
	 */
	@GetMapping("/login")
	public String showLoginForm(Model model) {
		model.addAttribute(LOGIN, new Users());
		return LOGIN; // JSP file name
	}

	/**
	 * Handles user login. On successful authentication, redirects to either HR or
	 * general home page based on user designation. On failure, returns to the login
	 * form with an error message.
	 * 
	 * @param usersDto The DTO containing login credentials.
	 * @param model    The model to pass attributes to the view.
	 * @param request  The HTTP request to manage the session.
	 * @return Redirect URL or view name based on the authentication outcome.
	 */
	@PostMapping("/login")
	public String loginUser(@ModelAttribute UsersDto usersDto, Model model, HttpServletRequest request) {
		Users authenticatedUser = usersService.authenticateUser(usersDto.getUserEmail(), usersDto.getUserPassword());

		if (authenticatedUser != null) {
			HttpSession session = request.getSession();
			session.setAttribute("designation", authenticatedUser.getUserDesignation());
			session.setAttribute("fullname", authenticatedUser.getUserFullname());
			if ("HR".equalsIgnoreCase(authenticatedUser.getUserDesignation())) {
				return "redirect:/user/hrhome?loginSuccess=Login successful, Welcome HR!";
			} else {
				return "redirect:/user/home?loginSuccess=Login successful, Welcome!";
			}
		} else {
			model.addAttribute("invalidUser", "Invalid email or password.");
			return LOGIN;
		}
	}

	/**
	 * Displays a list of all users based on the session's designation. Includes a
	 * message if a user was added recently.
	 * 
	 * @param userAdded Optional message indicating a successful user addition.
	 * @param model     The model to pass attributes to the view.
	 * @param request   The HTTP request to manage the session.
	 * @return The name of the JSP file to display based on user designation.
	 */
	@GetMapping("/getallusers")
	public String getAllUsers(Model model, @RequestParam(value = "userAdded", required = false) String userAdded,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		String designation = (String) session.getAttribute("designation");
		List<Users> userList = usersService.getAllUsers();
		model.addAttribute("userList", userList);
		if (userAdded != null) {
			model.addAttribute("userAdded", userAdded);
		}
		if ("HR".equalsIgnoreCase(designation))
			return "hremployeelist";
		else {
			return "employeelist";
		}
	}

	/**
	 * Displays the form to update user details for a specific user.
	 * 
	 * @param userId The ID of the user to be updated.
	 * @param model  The model to pass attributes to the view.
	 * @return The name of the JSP file to display.
	 */
	@GetMapping("/updateuser")
	public String showUpdateForm(@RequestParam("userId") String userId, Model model) {
		Users user = usersService.getUserById(userId);
		model.addAttribute("user", user);
		model.addAttribute("designationList", usersService.getdesignations());
		model.addAttribute("managerList", usersService.getUsersWithManagerDesignations());
		return "updateemployee";
	}

	/**
	 * Handles the update of user details. On success, redirects to the list of
	 * users. On failure, returns to the update form with an error message.
	 * 
	 * @param usersDto The DTO containing updated user details.
	 * @param model    The model to pass attributes to the view.
	 * @return Redirect URL or view name based on the outcome of the update.
	 */
	@PostMapping("/updateuser")
	public String updateUser(@ModelAttribute UsersDto usersDto, Model model) {
		Boolean isUpdated = usersService.updateUser(usersDto);
		if (Boolean.TRUE.equals(isUpdated)) {
			return "redirect:/user/getallusers?userAdded=User updated successfully!";
		} else {
			model.addAttribute("alreadyExists", "User not updated, Please try again!");
			return "updateemployee";
		}
	}

	/**
	 * Displays the home page with a list of meeting rooms and slots. Includes a
	 * message if login was successful.
	 * 
	 * @param loginSuccess Optional message indicating a successful login.
	 * @param model        The model to pass attributes to the view.
	 * @return The name of the JSP file to display.
	 */
	@GetMapping("/home")
	public String showHomePage(@RequestParam(value = "loginSuccess", required = false) String loginSuccess,
			Model model) {
		FilteredDataDto response = usersService.meetingRoomAndSlots();

		model.addAttribute("roomList", response.getMeetingRooms());
		model.addAttribute("slotList", response.getSlots());

		if (loginSuccess != null) {
			model.addAttribute("loginSuccess", loginSuccess);
		}
		return "home";
	}

	/**
	 * Displays the HR-specific home page with a list of meeting rooms and slots.
	 * Includes a message if login was successful.
	 * 
	 * @param loginSuccess Optional message indicating a successful login.
	 * @param model        The model to pass attributes to the view.
	 * @return The name of the JSP file to display.
	 */
	@GetMapping("/hrhome")
	public String showHrHomePage(@RequestParam(value = "loginSuccess", required = false) String loginSuccess,
			Model model) {
		FilteredDataDto response = usersService.meetingRoomAndSlots();

		model.addAttribute("roomList", response.getMeetingRooms());
		model.addAttribute("slotList", response.getSlots());
		if (loginSuccess != null) {
			model.addAttribute("loginSuccess", loginSuccess);
		}
		return "hrhome";
	}

	/**
	 * Displays the user's profile page with an optional update message and a list
	 * of team members.
	 * 
	 * @param updated Optional message indicating a successful profile update.
	 * @param model   The model to pass attributes to the view.
	 * @param session The HTTP session to retrieve the current user's full name.
	 * @return The name of the JSP file to display.
	 */
	@GetMapping("/profile")
	public String showProfile(@RequestParam(value = "updated", required = false) String updated, Model model,
			HttpSession session) {
		if (updated != null) {
			model.addAttribute("updated", updated);
		}
		String name = (String) session.getAttribute("fullname");
		Users user = usersService.getUserByName(name);
		List<Users> userTeam = usersService.getAllUsers();
		model.addAttribute("user", user);
		model.addAttribute("userTeam", userTeam);
		return "profile";
	}

	/**
	 * Displays the form to update the user's password.
	 * 
	 * @param userId The ID of the user whose password is to be updated.
	 * @param model  The model to pass attributes to the view.
	 * @return The name of the JSP file to display.
	 */
	@GetMapping("/updatepassword")
	public String getPasswordForm(@RequestParam("userId") String userId, Model model) {
		Users user = usersService.getUserById(userId);
		model.addAttribute("user", user);
		return "updatepassword";
	}

	/**
	 * Handles the password update process. On success, redirects to the profile
	 * page with an update message. On failure, redirects to the profile page with
	 * an error message.
	 * 
	 * @param userFullname The full name of the user whose password is being
	 *                     updated.
	 * @param userPassword The current password of the user.
	 * @param newPassword  The new password to set.
	 * @param model        The model to pass attributes to the view.
	 * @return Redirect URL based on the outcome of the password update.
	 */
	@PostMapping("/updatepassword")
	public String updatePassword(@RequestParam("userFullname") String userFullname,
			@RequestParam("userPassword") String userPassword, @RequestParam("newPassword") String newPassword,
			Model model) {
		boolean success = usersService.updatePassword(userFullname, userPassword, newPassword);
		if (success) {
			return "redirect:/user/profile?updated=Password updated successfully!";
		} else {
			return "redirect:/user/profile?error=Current password is wrong!";
		}
	}

	/**
	 * Logs out the current user by invalidating the session and then redirects to
	 * the index page with a logout message.
	 * 
	 * @param request The HTTP request used to get the current session.
	 * @param model   The model to pass attributes to the view (if needed).
	 * @return The redirect URL for the index page with a logout message.
	 */
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		return "redirect:/user/index?loggedOut=true";
	}

	/**
	 * Displays the index page with an optional logout message if the user has been
	 * logged out recently.
	 * 
	 * @param loggedOut Optional message indicating a successful logout.
	 * @param model     The model to pass attributes to the view.
	 * @return The name of the JSP file to display.
	 */
	@GetMapping("/index")
	public String index(@RequestParam(value = "loggedOut", required = false) String loggedOut, Model model) {
		if ("true".equals(loggedOut)) {
			model.addAttribute("loggedOut", "Logout Successful!");
		}
		return "index";
	}
}
