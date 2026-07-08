From `man paru.conf`:

> PKGBUILD REPOSITORY SECTION
>     PKGBUILD repositories can be defined by adding a [reponame] section, where reponame is the name of the repository you wish to add.
>
>     A PKGBUILD repository acts very much like the AUR in terms of package installation and upgrades. Packages in PKGBUILD repositories also take priority over the AUR so may be used to mask packages.
>
>     The layout of a PKGBUILD repository is simply a directory that contains PKGBUILDs.  Paru will recursively scan a repository for PKGBUILDs, up to 3 levels by default.
>
>     Paru will refresh PKGBUILD repositories when it refreshes repository databases.  Refreshing just PKGBUILD repositories can be done with paru -Sya.
>
>     Url = https://path/to/repo
>            Git URL to the PKGBUILD repository. File paths may be used to point to git repos on disk.
>
>            If Path is specified alongside Url, the specified path will be treated as a subdirectory of the repository and paru will only search for pkgbuilds in that subdirectory.
>
>     Path = /path/to/repo
>            Can be used as an alternative to URL to point to a PKGBUILD repository on disk.  Unlike using a URL path, changes to this directory are propagated to paru immediately and not on paru -Sya. There is also no review step for this kind of repository.
>
>     Depth = N
>            The search depth for PKGBUILD scanning.
>
>     SkipReview
>            Skip review for this repository.
>
>     GenerateSrcinfo
>            Force regeneration of the .SRCINFO file even if it exists on disk. This is useful for repositories that forget to update their .SRCINFO files.

Add to your `/etc/paru.conf`:

```
[options]
# optional, disables regular AUR
Mode = repo,pkgbuilds

[argonaut0]
URL = https://github.com/argonaut0/pkgbuilds
Depth = 3
# if you trust me ;)
SkipReview
```
