import consumer from "./consumer";

const initNotificationsCable = () => {
  const notificationsContainer = document.getElementById("notifications-counter");

  consumer.subscriptions.create("NotificationsChannel", {
    received(data) {
      notificationsContainer.insertAdjacentHTML('beforeend', data);
      notificationsContainer.classList.remove('d-none');
    },
  });
}

export { initNotificationsCable };
