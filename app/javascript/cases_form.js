function calculateDays(startDate, endDate) {
  const start = new Date(startDate);
  const end = new Date(endDate);

  if (!isNaN(start) && !isNaN(end)) {
    const diffTime = Math.abs(end - start);
    return Math.ceil(diffTime / (1000 * 60 * 60 * 24)); // Convert milliseconds to days
  }
  return "";
}

function updateGrantDays() {
  const lodgementDateField = document.getElementById("lodgement_date");
  const grantDateField = document.getElementById("grant_date");
  const grantDaysField = document.getElementById("grant_days");

  if (lodgementDateField && grantDateField && grantDaysField) {
    if (lodgementDateField.value && grantDateField.value) {
      grantDaysField.value = calculateDays(lodgementDateField.value, grantDateField.value);
    }
  }
}

function updateDaysToCoContact() {
  const lodgementDateField = document.getElementById("lodgement_date");
  const coResponseDateField = document.getElementById("co_response_date");
  const daysToCoContactField = document.getElementById("days_to_co_contact");

  if (lodgementDateField && coResponseDateField && daysToCoContactField) {
    if (lodgementDateField.value && coResponseDateField.value) {
      daysToCoContactField.value = calculateDays(lodgementDateField.value, coResponseDateField.value);
    }
  }
}

function updateDaysGrantAfterCoContact() {
  const coResponseDateField = document.getElementById("co_response_date");
  const grantDateField = document.getElementById("grant_date");
  const daysGrantAfterCoContactField = document.getElementById("days_grant_aftr_co_contact");

  if (coResponseDateField && grantDateField && daysGrantAfterCoContactField) {
    if (coResponseDateField.value && grantDateField.value) {
      daysGrantAfterCoContactField.value = calculateDays(coResponseDateField.value, grantDateField.value);
    }
  }
}

console.log("cases_form.js loaded with inline event listeners");
