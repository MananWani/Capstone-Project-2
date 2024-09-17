function validate() {
        var currentPassword = document.getElementById('userPassword').value;
        var newPassword = document.getElementById('newPassword').value;
        var confirmPassword = document.getElementById('confirmPassword').value;

        var currentPasswordError = document.getElementById('userPasswordError');
        var newPasswordError = document.getElementById('newPasswordError');
        var confirmPasswordError = document.getElementById('confirmPasswordError');

        var valid = true;

        newPasswordError.textContent = '';
        confirmPasswordError.textContent = '';
        currentPasswordError.textContent = '';

        var passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%?&])[A-Za-z\d@$!%*?&]{8,}$/;

        if (currentPassword === '') {
            currentPasswordError.textContent = 'Current Password cannot be empty.';
            valid = false;
        }
        if (newPassword === '') {
            newPasswordError.textContent = 'New Password cannot be empty.';
            valid = false;
        } else if (!passwordRegex.test(newPassword)) {
            newPasswordError.textContent = 'Password must be at least 8 characters long and contain at least one uppercase letter, one digit, and one special character.';
            valid = false;
        } else if (newPassword === currentPassword) {
            newPasswordError.textContent = 'New Password and Current Password cannot match.';
            valid = false;
        }
        if (confirmPassword === '') {
            confirmPasswordError.textContent = 'Confirm Password cannot be empty.';
            valid = false;
        } else if (newPassword !== confirmPassword) {
            confirmPasswordError.textContent = 'New Passwords do not match.';
            valid = false;
        }

        return valid;
}