enum ContactRole {
  Unknown,
  Missile,
  Target
}

interface IContactable {
  void madeContact(IContactable other);
  ContactRole getContactRole();
}