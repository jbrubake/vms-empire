Name: vms-empire
Version: 1.6
Release: 1
URL: http://www.catb.org/~esr/vms-empire/
Source: %{name}-%{version}.tar.gz
License: GPL-like
Group: Games
Summary: Solitaire Empire (sometimes called `VMS Empire')
BuildRoot: %{_tmppath}/%{name}-root

%description
Empire is a simulation of a full-scale war between two
emperors, the computer and you.  Naturally, there is only
room for one, so the object of the game is to destroy
the other.  The computer plays by the same rules that you
do.  This game is the ancestor of all the multiplayer Empire
simulations out there.

%prep
%setup -q

%build
make %{?_smp_mflags} vms-empire vms-empire.6

%install
[ "$RPM_BUILD_ROOT" -a "$RPM_BUILD_ROOT" != / ] && rm -rf "$RPM_BUILD_ROOT"
mkdir -p "$RPM_BUILD_ROOT"%{_bindir}
mkdir -p "$RPM_BUILD_ROOT"%{_mandir}/man6/
cp vms-empire "$RPM_BUILD_ROOT"%{_bindir}
cp vms-empire.6 "$RPM_BUILD_ROOT"%{_mandir}/man6/

%clean
[ "$RPM_BUILD_ROOT" -a "$RPM_BUILD_ROOT" != / ] && rm -rf "$RPM_BUILD_ROOT"

%files
%doc README COPYING
%defattr(-,root,root,-)
%{_mandir}/man6/vms-empire.6*
%{_bindir}/vms-empire

%changelog
* Mon Dec 29 2003 Eric S. Raymond <esr@snark.thyrsus.com> 1.6-1
- Source RPMs can be built by non-root user.

* Tue Dec 16 2003 Eric S. Raymond <esr@snark.thyrsus.com> 1.5-1
- Cleanup release with new build machinery.

