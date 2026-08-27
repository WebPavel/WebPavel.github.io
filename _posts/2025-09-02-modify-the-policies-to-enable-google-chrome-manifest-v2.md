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

## mv2 .crx backup

> [!NOTE]
> Aug 31st 2026: All remaining Manifest V2 extensions removed from the Chrome Web Store.

1. download and install the .crx [chromium-web-store](https://github.com/NeverDecaf/chromium-web-store) from [GitHub Releases](https://github.com/NeverDecaf/chromium-web-store/releases/download/v1.5.5.3/Chromium.Web.Store.crx)
2. download and back up mv2 extensions from [Chrome Web Store](https://chrome.google.com/webstore/category/extensions) directly using the extension above
3. list the backup extensions that I have already installed and that are scheduled to be deprecated on August 31, 2026.

|            CRX            |      category      |                                                   URL                                                    |  Version  |                                                 direct link                                                  |
|:-------------------------:|:------------------:|:--------------------------------------------------------------------------------------------------------:|:---------:|:------------------------------------------------------------------------------------------------------------:|
|          Feedbro          |   News & Weather   |       [Feedbro](https://chromewebstore.google.com/detail/feedbro/mefgmmbdailogpfhfblcnnjfmnpnmdfa)       |  4.16.3   |  [MEFGMMBDAILOGPFHFBLCNNJFMNPNMDFA_4_16_3_0.crx](/assets/mv2/MEFGMMBDAILOGPFHFBLCNNJFMNPNMDFA_4_16_3_0.crx)  |
|          Imagus           |    Art & Design    |        [Imagus](https://chromewebstore.google.com/detail/imagus/immpkjjlgappgfkkfieppnmlhakdmaab)        |  0.9.9.1  |   [IMMPKJJLGAPPGFKKFIEPPNMLHAKDMAAB_0_9_9_1.crx](/assets/mv2/IMMPKJJLGAPPGFKKFIEPPNMLHAKDMAAB_0_9_9_1.crx)   |
| uBlock Origin<sup>*</sup> | Privacy & Security | [uBlock Origin](https://chromewebstore.google.com/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm) |  1.74.0   |  [CJPALHDLNBPAFIAMEJDNHCPHJBKEIAGM_1_74_0_0.crx](/assets/mv2/CJPALHDLNBPAFIAMEJDNHCPHJBKEIAGM_1_74_0_0.crx)  |

> __*__:
>   - uBlock Origin: you can still download it directly from [GitHub Releases](https://github.com/gorhill/uBlock/releases)

## Reference

- [Chrome Enterprise Policy List & Management](https://chromeenterprise.google/policies/#ExtensionManifestV2Availability)
- [Manage Chrome updates (Mac)](https://support.google.com/chrome/a/answer/7591084)
- [Frequently Asked Questions \| ungoogled-chromium Wiki](https://ungoogled-software.github.io/ungoogled-chromium-wiki/faq)
- [chromium-web-store](https://github.com/NeverDecaf/chromium-web-store)
