document.addEventListener('DOMContentLoaded', function() {
	let isRoomNameValid = false;
	let isCapacityValid = false;
	let isEquipmentSelected = false;

	const roomNameRegex = /^[A-Za-z ]{3,30}$/;

	function validateRoomName() {
		const roomName = document.getElementById('roomName').value;
		const nameError = document.getElementById('nameError');
		if (!roomNameRegex.test(roomName)) {
			nameError.textContent = 'Room name must be between 3 - 30 letters';
			nameError.classList.add('show');
			isRoomNameValid = false;
		} else {
			nameError.textContent = '';
			nameError.classList.remove('show');
			isRoomNameValid = true;
		}
		checkAllValidations();
	}

	function validateCapacity() {
		const roomCapacity = document.getElementById('roomCapacity').value;
		const capacityError = document.getElementById('capacityError');
		if (roomCapacity < 5 || roomCapacity > 30) {
			capacityError.textContent = 'Room capacity can be in range 5-30';
			capacityError.classList.add('show');
			isCapacityValid = false;
		} else {
			capacityError.textContent = '';
			capacityError.classList.remove('show');
			isCapacityValid = true;
		}
		checkAllValidations();
	}

	function checkEquipmentSelection() {
		const checkboxes = document.querySelectorAll('input[name="selectedEquipments"]:checked');
		isEquipmentSelected = checkboxes.length > 0;
		checkAllValidations();
	}

	function checkAllValidations() {
		const registerButton = document.getElementById('registerButton');
		if (isRoomNameValid && isCapacityValid && isEquipmentSelected) {
			registerButton.classList.add('show');
		} else {
			registerButton.classList.remove('show');
		}
	}

	document.getElementById('roomCapacity').addEventListener('input', validateCapacity);
	document.getElementById('roomName').addEventListener('input', validateRoomName);

	document.querySelectorAll('input[name="selectedEquipments"]').forEach(checkbox => {
		checkbox.addEventListener('change', checkEquipmentSelection);
	});

	document.getElementById('registerForm').addEventListener('submit', function(event) {
		validateRoomName();
		validateCapacity();
		checkEquipmentSelection();
		if (!isRoomNameValid || !isCapacityValid || !isEquipmentSelected) {
			event.preventDefault();
		}
	});
});
