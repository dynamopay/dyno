#!/bin/bash

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

DYNOD=${DYNOD:-$BINDIR/dynod}
DYNOCLI=${DYNOCLI:-$BINDIR/dyno-cli}
DYNOTX=${DYNOTX:-$BINDIR/dyno-tx}
DYNOQT=${DYNOQT:-$BINDIR/qt/dyno-qt}

[ ! -x $DYNOD ] && echo "$DYNOD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BTCVER=($($DYNOCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for dynod if --version-string is not set,
# but has different outcomes for dyno-qt and dyno-cli.
echo "[COPYRIGHT]" > footer.h2m
$DYNOD --version | sed -n '1!p' >> footer.h2m

for cmd in $DYNOD $DYNOCLI $DYNOTX $DYNOQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
