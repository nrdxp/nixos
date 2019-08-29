{ usr, ... }:
{
  hashedPassword = usr.pwHash.root;
}
