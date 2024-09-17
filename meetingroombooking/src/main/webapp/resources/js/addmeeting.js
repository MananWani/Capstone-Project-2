document.addEventListener('DOMContentLoaded', function() {
    let isStartTimeValid = false;
    let isEndTimeValid = false;
    let isPurposeValid = false;
    let isStatusValid = false;
    let isRoomValid = false;
    let isParticipantSelected = false;

    const purposeMinLength = 5;
    const purposeMaxLength = 100;

    function validateStartTime() {
        const startTime = new Date(document.getElementById('meetingStartTime').value);
        const now = new Date();
        const startTimeError = document.getElementById('startTimeError');

        if (startTime <= now) {
            startTimeError.textContent = 'Start time cannot be in the past';
            startTimeError.classList.add('show');
            isStartTimeValid = false;
        } else {
            startTimeError.textContent = '';
            startTimeError.classList.remove('show');
            isStartTimeValid = true;
        }
        checkAllValidations();
    }

    function validateEndTime() {
        const endTime = new Date(document.getElementById('meetingEndTime').value);
        const startTime = new Date(document.getElementById('meetingStartTime').value);
        const now = new Date();
        const endTimeError = document.getElementById('endTimeError');

        if (endTime <= now) {
            endTimeError.textContent = 'End time cannot be in the past';
            endTimeError.classList.add('show');
            isEndTimeValid = false;
        } else if (endTime <= startTime) {
            endTimeError.textContent = 'End time must be after start time';
            endTimeError.classList.add('show');
            isEndTimeValid = false;
        } else {
            endTimeError.textContent = '';
            endTimeError.classList.remove('show');
            isEndTimeValid = true;
        }
        checkAllValidations();
    }

    function validatePurpose() {
        const purpose = document.getElementById('meetingPurpose').value;
        const purposeError = document.getElementById('purposeError');

        if (purpose.length < purposeMinLength || purpose.length > purposeMaxLength) {
            purposeError.textContent = `Purpose must be between ${purposeMinLength}-${purposeMaxLength} characters`;
            purposeError.classList.add('show');
            isPurposeValid = false;
        } else {
            purposeError.textContent = '';
            purposeError.classList.remove('show');
            isPurposeValid = true;
        }
        checkAllValidations();
    }

    function validateStatus() {
        const status = document.getElementById('meetingStatus').value;
        const statusError = document.getElementById('statusError');

        if (status === '') {
            statusError.textContent = 'Please select a status';
            statusError.classList.add('show');
            isStatusValid = false;
        } else {
            statusError.textContent = '';
            statusError.classList.remove('show');
            isStatusValid = true;
        }
        checkAllValidations();
    }

    function validateRoom() {
        const room = document.getElementById('meetingInRoom').value;
        const roomError = document.getElementById('roomError');

        if (room === '') {
            roomError.textContent = 'Please select a room';
            roomError.classList.add('show');
            isRoomValid = false;
        } else {
            roomError.textContent = '';
            roomError.classList.remove('show');
            isRoomValid = true;
        }
        checkAllValidations();
    }

    function checkParticipantSelection() {
        const checkboxes = document.querySelectorAll('input[name="participants"]:checked');
        isParticipantSelected = checkboxes.length > 0;
        const participantError = document.getElementById('participantsError');

        if (!isParticipantSelected) {
            participantError.textContent = 'Please select at least one participant';
            participantError.classList.add('show');
        } else {
            participantError.textContent = '';
            participantError.classList.remove('show');
        }
        checkAllValidations();
    }

    function toggleAllParticipants(checked) {
        document.querySelectorAll('input[name="participants"]').forEach(checkbox => {
            checkbox.checked = checked;
        });
        checkParticipantSelection();
    }

    function checkAllValidations() {
        const saveButton = document.getElementById('saveButton');
        if (isStartTimeValid && isEndTimeValid && isPurposeValid && isStatusValid && isRoomValid && isParticipantSelected) {
            saveButton.classList.add('show');
        } else {
            saveButton.classList.remove('show');
        }
    }

    document.getElementById('meetingStartTime').addEventListener('input', validateStartTime);
    document.getElementById('meetingEndTime').addEventListener('input', validateEndTime);
    document.getElementById('meetingPurpose').addEventListener('input', validatePurpose);
    document.getElementById('meetingStatus').addEventListener('change', validateStatus);
    document.getElementById('meetingInRoom').addEventListener('change', validateRoom);
    document.querySelectorAll('input[name="participants"]').forEach(checkbox => {
        checkbox.addEventListener('change', checkParticipantSelection);
    });

    // Add event listener for the "Select All" checkbox
    document.getElementById('selectAllParticipants').addEventListener('change', function() {
        toggleAllParticipants(this.checked);
    });

    document.getElementById('meetingForm').addEventListener('submit', function(event) {
        validateStartTime();
        validateEndTime();
        validatePurpose();
        validateStatus();
        validateRoom();
        checkParticipantSelection();
        if (!isStartTimeValid || !isEndTimeValid || !isPurposeValid || !isStatusValid || !isRoomValid || !isParticipantSelected) {
            event.preventDefault();
        }
    });
});
