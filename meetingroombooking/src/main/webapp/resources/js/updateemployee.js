document
	.addEventListener(
		'DOMContentLoaded',
		function() {

			let isManagerValid = false;
			let isDesignationValid = false;
			let isMobileValid = false;

			const mobileRegex = /^[6789]\d{9}$/;



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

			function validateMobile() {
				const mobile = document.getElementById('userMobileNo').value;
				const mobileError = document
					.getElementById('mobileError');
				if (!mobileRegex.test(mobile)) {
					mobileError.textContent = 'Please enter a valid Indian number';
					mobileError.classList.add('show');
					isMobileValid = false;
				} else {
					mobileError.textContent = '';
					mobileError.classList.remove('show');
					isMobileValid = true;
				}
				checkAllValidations();
			}

			function checkAllValidations() {
				const registerButton = document
					.getElementById('registerButton');
				if (isManagerValid && isDesignationValid && isMobileValid) {
					registerButton.classList.add('show');
				} else {
					registerButton.classList.remove('show');
				}
			}


			document.getElementById('userMobileNo').addEventListener(
				'input', validateMobile);
			document.getElementById('userUnderManager').addEventListener('change', validateManager);
			document.getElementById('userDesignation').addEventListener('change', validateDesignation);





			document.getElementById('registerForm').addEventListener('submit', function(event) {
				validateManager();
				validateDesignation();
				validateMobile();
				if (!isManagerValid || !isDesignationValid || !isMobileValid
				) {
					event.preventDefault();
				}
			});
		});