Name: vms-empire
Version: 1.3
Release: 1
Source: locke.ccil.org:/pub/esr/vms-empire-1.3.tar.gz
Copyright: BSD-like
Group: Games
Summary: Solitaire Empire (sometimes called `VMS Empire')

%description
Solitaire Empire (sometimes called `VMS Empire')

%prep
%setup

%build
make

%install
cp vms-empire /usr/bin
cp vms-empire.6 /usr/share/man/man6/vms-empire.6

%files
/usr/share/man/man6/vms-empire.6
/usr/bin/vms-empire
