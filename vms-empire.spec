Name: vms-empire
Version: 1.8
Release: 1
URL: http://www.catb.org/~esr/vms-empire/
Source: %{name}-%{version}.tar.gz
License: GPL
Group: Games
Summary: Solitaire Empire (sometimes called `VMS Empire')
BuildRoot: %{_tmppath}/%{name}-root
#Logo: empire-logo.png

%description
Empire is a simulation of a full-scale war between two emperors, the
computer and you.  Naturally, there is only room for one, so the
object of the game is to destroy the other.  The computer plays by the
same rules that you do.  This game was ancestral to later
expand/explore/exploit/exterminate games, including Civilization and
Master of Orion.
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
* Thu Oct 21 2010 Eric S. Raymond <esr@snark.thyrsus.com> - 1.8-1
- Joe Wells's patch to enable different-sized worlds.  Minor fixes to 
  map functions by Andrew Morrow. More on the history of the game.
  Enable arrow keys in edit mode.
- License changed from Chuck Simmons's cosmetically tweaked clone
  of the GPL to GPL proper, so the classifier systems that forge
  and archive sites use will be less confused.

* Mon Sep 27 2004 Eric S. Raymond <esr@snark.thyrsus.com> 1.7-1
- Documentation fixes.  The old empire.doc file has been replaced
  by the man page.

* Mon Dec 29 2003 Eric S. Raymond <esr@snark.thyrsus.com> 1.6-1
- Source RPMs can be built by non-root user.

* Tue Dec 16 2003 Eric S. Raymond <esr@snark.thyrsus.com> 1.5-1
- Cleanup release with new build machinery.

