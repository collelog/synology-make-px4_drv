#!/bin/bash
# Signing information found at https://forum.synology.com/enu/viewtopic.php?t=98760

spk_in="$1"
spk_out="$2"
tmpdir=`mktemp -d -t dsmpkg-sign.XXXXXXXX`
tmpcatfile=`mktemp -t dsmpkg-sign.XXXXXXXX`
tmpsigfile=`mktemp -t dsmpkg-signature.XXXXXXXX`

tar xfz "$spk_in" -C "$tmpdir"
rm -rf "$tmpdir/syno_signature.asc"
cat `find $tmpdir -xtype f | sort --version-sort` > "$tmpcatfile"
gpg --armor --detach-sign --yes --output "$tmpsigfile" "$tmpcatfile"
curl --form "file=@$tmpsigfile" "http://timestamp.synology.com/timestamp.php" > "$tmpdir/syno_signature.asc"
tar cfz "$spk_out" -C "$tmpdir" `ls -1 "$tmpdir"`

rm -rf "$tmpdir" "$tmpcatfile" "$tmpsigfile"

