document.addEventListener("DOMContentLoaded", () => {
  // Get the input elements for dates and other fields
  const lodgementDateInput = document.getElementById("lodgement_date");
  const grantDateInput = document.getElementById("grant_date");
  const coResponseDateInput = document.getElementById("co_response_date");
  const grantDaysInput = document.getElementById("grant_days");
  const daysToCoContactInput = document.getElementById("days_to_co_contact");
  const daysGrantAfterCoContactInput = document.getElementById("days_grant_aftr_co_contact");
  const lastLoginAtInput = document.querySelector("input[name='case[last_login_at]']");
  const daysAftrAssessInput = document.querySelector("input[name='case[days_aftr_assess]']");

  // Function to calculate days between two dates
  const calculateDays = (startDate, endDate) => {
    if (!startDate || !endDate) return null;
    const start = new Date(startDate);
    const end = new Date(endDate);
    if (end < start) {
      alert("The end date cannot be earlier than the start date.");
      return null;
    }
    return Math.ceil((end - start) / (1000 * 60 * 60 * 24));
  };

  // Function to calculate days after last login
  const calculateDaysAfterLogin = () => {
    const lastLoginAt = lastLoginAtInput ? lastLoginAtInput.value : null;
    if (!lastLoginAt || !daysAftrAssessInput) return;

    const lastLoginDate = new Date(lastLoginAt);
    const today = new Date();

    // Calculate the difference in time
    const timeDiff = today - lastLoginDate; // in milliseconds
    const daysDiff = Math.floor(timeDiff / (1000 * 3600 * 24)); // convert to days

    // Update the days after last login input
    daysAftrAssessInput.value = daysDiff;
  };

  // Update "Grant Days" when lodgement and grant dates change
  const updateGrantDays = () => {
    const lodgementDate = lodgementDateInput.value;
    const grantDate = grantDateInput.value;
    if (lodgementDate && grantDate) {
      const days = calculateDays(lodgementDate, grantDate);
      if (days !== null) grantDaysInput.value = days;
    }
  };

  // Update "Days to CO Contact" when lodgement and CO response dates change
  const updateDaysToCoContact = () => {
    const lodgementDate = lodgementDateInput.value;
    const coResponseDate = coResponseDateInput.value;
    if (lodgementDate && coResponseDate) {
      const days = calculateDays(lodgementDate, coResponseDate);
      if (days !== null) daysToCoContactInput.value = days;
    }
  };

  // Update "Days Grant After CO Contact" when grant date and CO response date change
  const updateDaysGrantAfterCoContact = () => {
    const coResponseDate = coResponseDateInput.value;
    const grantDate = grantDateInput.value;
    if (grantDate) {
      if (coResponseDate) {
        const days = calculateDays(coResponseDate, grantDate);
        if (days !== null) daysGrantAfterCoContactInput.value = days;
      } else {
        daysGrantAfterCoContactInput.value = 0; // No CO contact, visa granted directly
      }
    }
  };

  // Call the function to update days after login on page load
  calculateDaysAfterLogin();

  // Attach event listeners to relevant fields
  lodgementDateInput.addEventListener("change", () => {
    updateGrantDays();
    updateDaysToCoContact();
    updateDaysGrantAfterCoContact();
  });

  grantDateInput.addEventListener("change", () => {
    updateGrantDays();
    updateDaysGrantAfterCoContact();
  });

  coResponseDateInput.addEventListener("change", () => {
    updateDaysToCoContact();
    updateDaysGrantAfterCoContact();
  });
});
