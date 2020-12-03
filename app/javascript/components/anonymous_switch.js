const anonymousSwitch = () => {
  const toggles = document.getElementsByClassName("toggle anon-switch");
  for (let toggle of toggles) {
    toggle.addEventListener("click", () => {
      const button = document.getElementById(`anon-switch-${toggle.id}`)
      button.submit();
    });
  }
};

export { anonymousSwitch };
