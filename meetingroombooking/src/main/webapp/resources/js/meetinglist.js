function openModal(meetingId) {
    document.getElementById('modal-' + meetingId).style.display = 'block';
}

function closeModal(meetingId) {
    document.getElementById('modal-' + meetingId).style.display = 'none';
}

// Close the modal if the user clicks outside of it
window.onclick = function(event) {
    var modals = document.getElementsByClassName('modal');
    for (var i = 0; i < modals.length; i++) {
        if (event.target == modals[i]) {
            modals[i].style.display = "none";
        }
    }
}
