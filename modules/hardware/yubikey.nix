{ ... }: {
  security.pam.u2f.settings = {
    pinverification = 1;
    cue = true;
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
    i3lock.u2fAuth = true;
  };
}
