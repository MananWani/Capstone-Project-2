document.addEventListener('DOMContentLoaded', function() {
    const email = document.getElementById('userEmail');
    const password = document.getElementById('userPassword');
    const loginButton = document.getElementById('loginButton');
    const eyeIcon = document.getElementById('togglePassword');
    const passwordContainer = document.querySelector('.password-container');

    function validateUsername() {
        return email.value.trim() !== '' && email.value.length >= 3 && email.value.length <= 50;
    }

    function validatePassword() {
        return password.value.trim() !== '' && password.value.length >= 8;
    }

    function updateButtonState() {
        if (validateUsername() && validatePassword()) {
            loginButton.classList.add('show');
        } else {
            loginButton.classList.remove('show');
        }
    }

    function toggleEyeIconVisibility() {
        if (password.value) {
            passwordContainer.classList.add('show-eye');
        } else {
            passwordContainer.classList.remove('show-eye');
        }
    }

    function togglePasswordVisibility() {
        if (password.type === 'password') {
            password.type = 'text';
            eyeIcon.classList.remove('fa-eye');
            eyeIcon.classList.add('fa-eye-slash');
        } else {
            password.type = 'password';
            eyeIcon.classList.remove('fa-eye-slash');
            eyeIcon.classList.add('fa-eye');
        }
    }

    email.addEventListener('input', updateButtonState);
    password.addEventListener('input', function() {
        updateButtonState();
        toggleEyeIconVisibility();
    });

    eyeIcon.addEventListener('click', togglePasswordVisibility);

    updateButtonState();
    toggleEyeIconVisibility();
});
