Name: vms-empire
Version: 1.5
Release: 1
URL: http://www.tuxedo.org/~esr/vms-empire/
Source: %{name}-%{version}.tar.gz
License: GPL-like
Group: Games
Summary: Solitaire Empire (sometimes called `VMS Empire')
%undefine __check_files

%description
Empire is a simulation of a full-scale war between two
emperors, the computer and you.  Naturally, there is only
room for one, so the object of the game is to destroy
the other.  The computer plays by the same rules that you
do.  This game is the ancestor of all the multiplayer Empire
simulations out there.

%prep
%setup

%build
make

%install
cp vms-empire /usr/bin
cp vms-empire.6 /usr/share/man/man6/vms-empire.6

%changelog
* Tue Dec 16 2003 Eric S. Raymond <esr@snark.thyrsus.com> 1.5-1
- Cleanup release with new build machinery.

%files
/usr/share/man/man6/vms-empire.6
/usr/bin/vms-empire
%doc READ.ME NEWS

