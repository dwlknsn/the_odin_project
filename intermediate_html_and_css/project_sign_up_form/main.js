const inputs = document.querySelectorAll("input");
const password = document.querySelector("#password");

inputs.forEach((input) => {
  input.addEventListener("focusout", () => {
    let valid = false;

    if (input.name === "password") {
      valid = input.value.length >= 8;
    } else if (input.name === "password-confirmation") {
      valid = password.value === input.value;
    } else {
      valid = input.checkValidity();
    }

    if (valid) {
      input.classList.remove("invalid");
      console.log(`${input.name} valid`);
    } else {
      console.log(`${input.name} invalid`);
      input.classList.add("invalid");
    }
  });
});

const form = document.querySelector("#registration-form");
const button = document.querySelector("#create-account-btn");

button.addEventListener("click", (event) => {
  console.log("click");
  event.preventDefault(); // prevent default form submission

  const formData = new FormData(form);
  const invalidFields = [];

  for (const [name, value] of formData.entries()) {
    const field = document.getElementById(name);
    if (!field.checkValidity()) {
      invalidFields.push(field);
      field.classList.add("invalid");
    } else {
      field.classList.remove("invalid");
    }
  }

  if (invalidFields.length > 0) {
    // display error message or highlight invalid fields
    console.log("Form is invalid");
  } else {
    // form is valid, submit it
    console.log("Form is valid");
    // form.submit();
  }
});
