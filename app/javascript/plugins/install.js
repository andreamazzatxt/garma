const installPWA = () => {
  let deferredPrompt;
  window.addEventListener('beforeinstallprompt', (e) => {
  // Prevent the mini-infobar from appearing on mobile
  e.preventDefault();
  // Stash the event so it can be triggered later.
  deferredPrompt = e;
  // Update UI notify the user they can install the PWA
  // Optionally, send analytics event that PWA install promo was shown.
  const installButton = document.getElementById('install-button')
  console.log(installButton);
  if(installButton){
    installButton.addEventListener('click', async () => {
    deferredPrompt.prompt();
    const { outcome } = await deferredPrompt.userChoice;
    console.log(`User response to the install prompt: ${outcome}`);
    deferredPrompt = null;
    })
  }
});
}

export { installPWA }
