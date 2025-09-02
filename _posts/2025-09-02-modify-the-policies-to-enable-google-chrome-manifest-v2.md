---
layout: post
title: "Modify the policies to enable Google Chrome Manifest V2"
date: 2025-09-02
excerpt: "Modify the policies to enable Google Chrome Manifest V2."
tags: [ Google Chrome, Manifest V2, MacOS ]
comments: true
---


# Modify the policies to enable Google Chrome Manifest V2

Due to the [policies](https://developer.chrome.com/docs/extensions/develop/migrate/mv2-deprecation-timeline), Manifest V2 will be deprecated after Chrome 138.

To enable Google Chrome Manifest V2, we can modify the Chrome policies.

## Control Manifest v2 extension availability && Configure auto-updates

```shell
#!/bin/bash
set -euxo pipefail

preferences="/Library/Managed Preferences"
if [ ! -d "$preferences" ]
then
  mkdir -p "$preferences"
fi

# https://chromeenterprise.google/policies/#ExtensionManifestV2Availability
sudo tee "$preferences/com.google.Chrome.plist" >/dev/null <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>ExtensionManifestV2Availability</key>
    <integer>2</integer>
  </dict>
</plist>
EOF

# https://support.google.com/chrome/a/answer/7591084
sudo tee "$preferences/com.google.Keystone.plist" >/dev/null <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>updatePolicies</key>
    <dict>
      <key>global</key>
      <dict>
        <key>UpdateDefault</key>
        <integer>3</integer>
      </dict>
    </dict>
  </dict>
</plist>
EOF
```

## Reference

[Chrome Enterprise Policy List & Management](https://chromeenterprise.google/policies/#ExtensionManifestV2Availability)

[Manage Chrome updates (Mac)](https://support.google.com/chrome/a/answer/7591084)
