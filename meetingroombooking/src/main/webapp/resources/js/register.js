document
	.addEventListener(
		'DOMContentLoaded',
		function() {

			let isEmailValid = false;
			let isUsernameValid = false;
			let isMobileValid = false;
			let isPasswordValid = false;
			let isManagerValid = false;
			let isDesignationValid = false;


			const emailRegex = /^[^\s@]+@crimsonlogic\.com$/;
			const usernameRegex = /^[A-Za-z ]{3,30}$/;
			const passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,15}$/;
			const mobileRegex = /^[6789]\d{9}$/;


			function validateEmail() {
				const email = document.getElementById('userEmail').value;
				const emailError = document
					.getElementById('emailError');
				if (!emailRegex.test(email)) {
					emailError.textContent = 'Invalid email address';
					emailError.classList.add('show');
					isEmailValid = false;
				} else {
					emailError.textContent = '';
					emailError.classList.remove('show');
					isEmailValid = true;
				}
				checkAllValidations();
			}

			function validateUsername() {
				const username = document.getElementById('userFullname').value;
				const nameError = document
					.getElementById('nameError');
				if (!usernameRegex.test(username)) {
					nameError.textContent = 'Username must be between 3 and 30 letters';
					nameError.classList.add('show');
					isUsernameValid = false;
				} else {
					nameError.textContent = '';
					nameError.classList.remove('show');
					isUsernameValid = true;
				}
				checkAllValidations();
			}

			function validateMobile() {
				const mobile = document.getElementById('userMobileNo').value;
				const mobileError = document
					.getElementById('mobileError');
				if (!mobileRegex.test(mobile)) {
					mobileError.textContent = 'Mobile number can start with [6,7,8,9] and can have 10 digits';
					mobileError.classList.add('show');
					isMobileValid = false;
				} else {
					mobileError.textContent = '';
					mobileError.classList.remove('show');
					isMobileValid = true;
				}
				checkAllValidations();
			}

			function validateDesignation() {
				const userDesignation = document.getElementById('userDesignation').value;
				const designationError = document.getElementById('designationError');
				if (userDesignation === '') {
					designationError.textContent = 'Please select a designation';
					designationError.classList.add('show');
					isDesignationValid = false;
				} else {
					designationError.textContent = '';
					designationError.classList.remove('show');
					isDesignationValid = true;
				}
				checkAllValidations();
			}

			function validatePassword() {
				const password = document
					.getElementById('userPassword').value;
				const passwordError = document
					.getElementById('passwordError');
				if (!passwordRegex.test(password)) {
					passwordError.textContent = 'Password must be 8-15 characters long, contain at least one uppercase letter, one digit, and one special character';
					passwordError.classList.add('show');
					isPasswordValid = false;
				} else {
					passwordError.textContent = '';
					passwordError.classList.remove('show');
					isPasswordValid = true;
				}
				checkAllValidations();
			}

			function validateManager() {
				const userUnderManager = document.getElementById('userUnderManager').value;
				const managerError = document.getElementById('managerError');
				if (userUnderManager === '') {
					managerError.textContent = 'Please select a manager';
					managerError.classList.add('show');
					isManagerValid = false;
				} else {
					managerError.textContent = '';
					managerError.classList.remove('show');
					isManagerValid = true;
				}
				checkAllValidations();
			}

			function checkAllValidations() {
				const registerButton = document
					.getElementById('registerButton');
				if (isEmailValid && isUsernameValid
					&& isPasswordValid
					&& isMobileValid && isManagerValid && isDesignationValid) {
					registerButton.classList.add('show');
				} else {
					registerButton.classList.remove('show');
				}
			}

			function toggleEyeIconVisibility() {
				const passwordField = document
					.getElementById('userPassword');

				const passwordContainer = document
					.getElementById('passwordContainer');


				if (passwordField.value) {
					passwordContainer.classList.add('show-eye');
				} else {
					passwordContainer.classList.remove('show-eye');
				}

			}

			function togglePasswordVisibility() {
				const passwordField = document
					.getElementById('userPassword');
				const eyeIcon = document
					.getElementById('togglePassword');

				if (passwordField.type === 'password') {
					passwordField.type = 'text';
					eyeIcon.classList.remove('fa-eye');
					eyeIcon.classList.add('fa-eye-slash');
				} else {
					passwordField.type = 'password';
					eyeIcon.classList.remove('fa-eye-slash');
					eyeIcon.classList.add('fa-eye');
				}

			}

			document.getElementById('userUnderManager').addEventListener('change', validateManager);
			document.getElementById('userDesignation').addEventListener('change', validateDesignation);

			document.getElementById('userEmail').addEventListener(
				'input', validateEmail);
			document.getElementById('userMobileNo').addEventListener(
				'input', validateMobile);
			document.getElementById('userFullname').addEventListener(
				'input', validateUsername);
			document.getElementById('userPassword').addEventListener(
				'input', function() {
					validatePassword();
					toggleEyeIconVisibility();
				});

			document.getElementById('togglePassword')
				.addEventListener('click',
					togglePasswordVisibility);


			toggleEyeIconVisibility();

			document.getElementById('registerForm').addEventListener('submit', function(event) {
				validateEmail();
				validateMobile();
				validateUsername();
				validatePassword();
				validateManager();
				validateDesignation();
				if (!isEmailValid || !isUsernameValid || !isPasswordValid || !isMobileValid
					|| !isManagerValid || !isDesignationValid
				) {
					event.preventDefault();
				}
			});
		});