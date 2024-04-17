---
theme: ../../theme
background: https://cover.sli.dev
title: Building Swift CLIs that your users and contributors love
highlighter: shiki
drawings:
  persist: false
mdc: true
---

<img src="/terminal.png" width="150" alt="An icon that represents a terminal"/>

# Building Swift CLIs that your users and contributors ❤️
## Swift Heroes 2024

---

# Introduction

<br/>

- Pedro Piñera
- Berlin-based 
- Open Source and developer tooling passionate
- Creator and maintainer of [Tuist](https://github.com/tuist/tuist) and [XcodeProj](https://github.com/tuist/xcodeproj)

---

<img src="/logo.png" class="w-50"/>
<h1>Tuist</h1>
<h2>Xcode senza pensieri</h2>
<h3>(We fight Xcode intricacies, so that you don't have to)</h3>
<h4>For my parents: we help developers stay productive</h4>

---

# Today's mission

## What 🦹‍♀️
- Inspire you to build your own CLIs

## How 👩‍💻
- Learn the basics
- Build (and learn about) a CLI together

---

# The basics
### CLIs are terminal apps

- **Composability:** They can interact with other CLIs (UNIX philosophy: Make each program do one thing well)
- **Arguments:** They can take arguments (e.g. `git commit -m "Message"`)
- **Streams:** They have three streams: standard input (stdin), standard output (stdout), and standard error (stderr)
- **Interactivity:** They can run in interactive an non-interactive modes
- **I/O:** File I/O, network I/O, process I/O, environment variables,...
- **Life-cycle:** One-off or daemon

### Examples
`git`, `swift`, `brew`, `tuist`, `fastlane`, `ruby`, ...

---

# But Pedro...
### What makes a CLI great? 🤷‍♀️

---

# xcodebuild

<Terminal>
<p>
        xcodebuild --help<br />Usage: xcodebuild [-project &lt;projectname&gt;]
        [[-target &lt;targetname&gt;]...|-alltargets] [-configuration
        &lt;configurationname&gt;] [-arch &lt;architecture&gt;]... [-sdk
        [&lt;sdkname&gt;|&lt;sdkpath&gt;]] [-showBuildSettings [-json]]
        [&lt;buildsetting&gt;=&lt;value&gt;]... [&lt;buildaction&gt;]...<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        xcodebuild [-project &lt;projectname&gt;] -scheme &lt;schemeName&gt;
        [-destination &lt;destinationspecifier&gt;]... [-configuration
        &lt;configurationname&gt;] [-arch &lt;architecture&gt;]... [-sdk
        [&lt;sdkname&gt;|&lt;sdkpath&gt;]] [-showBuildSettings [-json]]
        [-showdestinations] [&lt;buildsetting&gt;=&lt;value&gt;]...
        [&lt;buildaction&gt;]...<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        xcodebuild -workspace &lt;workspacename&gt; -scheme &lt;schemeName&gt;
        [-destination &lt;destinationspecifier&gt;]... [-configuration
        &lt;configurationname&gt;] [-arch &lt;architecture&gt;]... [-sdk
        [&lt;sdkname&gt;|&lt;sdkpath&gt;]] [-showBuildSettings]
        [-showdestinations] [&lt;buildsetting&gt;=&lt;value&gt;]...
        [&lt;buildaction&gt;]...<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        xcodebuild -version [-sdk [&lt;sdkfullpath&gt;|&lt;sdkname&gt;] [-json]
        [&lt;infoitem&gt;] ]<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        xcodebuild -list [[-project &lt;projectname&gt;]|[-workspace
        &lt;workspacename&gt;]] [-json]<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        xcodebuild -showsdks [-json]<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        xcodebuild -exportArchive -archivePath &lt;xcarchivepath&gt;
        [-exportPath &lt;destinationpath&gt;] -exportOptionsPlist
        &lt;plistpath&gt;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcodebuild
        -exportNotarizedApp -archivePath &lt;xcarchivepath&gt; -exportPath
        &lt;destinationpath&gt;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        xcodebuild -exportLocalizations -localizationPath &lt;path&gt; -project
        &lt;projectname&gt; [-defaultLanguage &lt;language&gt;] [-exportLanguage
        &lt;targetlanguage&gt;... [-includeScreenshots]]<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        xcodebuild -importLocalizations -localizationPath &lt;path&gt; -project
        &lt;projectname&gt; [-mergeImport]<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        xcodebuild -resolvePackageDependencies [-project
        &lt;projectname&gt;|-workspace &lt;workspacename&gt;]
        -clonedSourcePackagesDirPath &lt;path&gt;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        xcodebuild -create-xcframework [-help] [-framework &lt;path&gt;]
        [-library &lt;path&gt; [-headers &lt;path&gt;]] -output &lt;path&gt;<br /><br />Options:<br />&nbsp;&nbsp;&nbsp;
        -usage&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        print brief usage<br />&nbsp;&nbsp;&nbsp;
        -help&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        print complete usage<br />&nbsp;&nbsp;&nbsp;
        -verbose&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        provide additional status output<br />&nbsp;&nbsp;&nbsp;
        -license&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        show the Xcode and SDK license agreements<br />&nbsp;&nbsp;&nbsp;
        -checkFirstLaunchStatus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Check if any First Launch tasks need to be performed<br />&nbsp;&nbsp;&nbsp;
        -runFirstLaunch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        install packages and agree to the license<br />&nbsp;&nbsp;&nbsp;
        -downloadAllPlatforms&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        download all platforms<br />&nbsp;&nbsp;&nbsp; -downloadPlatform
        NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        download the platform NAME<br />&nbsp;&nbsp;&nbsp; -project
        NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        build the project NAME<br />&nbsp;&nbsp;&nbsp; -target
        NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        build the target NAME<br />&nbsp;&nbsp;&nbsp;
        -alltargets&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        build all targets<br />&nbsp;&nbsp;&nbsp; -workspace
        NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        build the workspace NAME<br />&nbsp;&nbsp;&nbsp; -scheme
        NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        build the scheme NAME<br />&nbsp;&nbsp;&nbsp; -configuration
        NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        use the build configuration NAME for building each target<br />&nbsp;&nbsp;&nbsp;
        -xcconfig
        PATH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        apply the build settings defined in the file at PATH as overrides<br />&nbsp;&nbsp;&nbsp;
        -arch
        ARCH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        build each target for the architecture ARCH; this will override
        architectures defined in the project<br />&nbsp;&nbsp;&nbsp; -sdk
        SDK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        use SDK as the name or path of the base SDK when building the project<br />&nbsp;&nbsp;&nbsp;
        -toolchain
        NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        use the toolchain with identifier or name NAME<br />&nbsp;&nbsp;&nbsp;
        -destination
        DESTINATIONSPECIFIER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        use the destination described by DESTINATIONSPECIFIER (a comma-separated
        set of key=value pairs describing the destination to use)<br />&nbsp;&nbsp;&nbsp;
        -destination-timeout
        TIMEOUT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        wait for TIMEOUT seconds while searching for the destination device<br />&nbsp;&nbsp;&nbsp;
        -parallelizeTargets&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        build independent targets in parallel<br />&nbsp;&nbsp;&nbsp; -jobs
        NUMBER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specify the maximum number of concurrent build operations<br />&nbsp;&nbsp;&nbsp;
        -maximum-concurrent-test-device-destinations
        NUMBER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the maximum number of device
        destinations to test on concurrently<br />&nbsp;&nbsp;&nbsp;
        -maximum-concurrent-test-simulator-destinations NUMBER&nbsp;&nbsp; the
        maximum number of simulator destinations to test on concurrently<br />&nbsp;&nbsp;&nbsp;
        -parallel-testing-enabled
        YES|NO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        overrides the per-target setting in the scheme<br />&nbsp;&nbsp;&nbsp;
        -parallel-testing-worker-count
        NUMBER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        the exact number of test runners that will be spawned during parallel
        testing<br />&nbsp;&nbsp;&nbsp; -maximum-parallel-testing-workers
        NUMBER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        the maximum number of test runners that will be spawned during parallel
        testing<br />&nbsp;&nbsp;&nbsp;
        -dry-run&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        do everything except actually running the commands<br />&nbsp;&nbsp;&nbsp;
        -quiet&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        do not print any output except for warnings and errors<br />&nbsp;&nbsp;&nbsp;
        -hideShellScriptEnvironment&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        don't show shell script environment variables in build log<br />&nbsp;&nbsp;&nbsp;
        -showsdks&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        display a compact list of the installed SDKs<br />&nbsp;&nbsp;&nbsp;
        -showdestinations&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        display a list of destinations<br />&nbsp;&nbsp;&nbsp;
        -showTestPlans&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        display a list of test plans<br />&nbsp;&nbsp;&nbsp;
        -showBuildSettings&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        display a list of build settings and values<br />&nbsp;&nbsp;&nbsp;
        -showBuildSettingsForIndex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        display build settings for the index service<br />&nbsp;&nbsp;&nbsp;
        -list&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        lists the targets and configurations in a project, or the schemes in a
        workspace<br />&nbsp;&nbsp;&nbsp; -find-executable
        NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        display the full path to executable NAME in the provided SDK and
        toolchain<br />&nbsp;&nbsp;&nbsp; -find-library
        NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        display the full path to library NAME in the provided SDK and
        toolchain<br />&nbsp;&nbsp;&nbsp;
        -version&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        display the version of Xcode; with -sdk will display info about one or
        all installed SDKs<br />&nbsp;&nbsp;&nbsp; -enableAddressSanitizer
        YES|NO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        turn the address sanitizer on or off<br />&nbsp;&nbsp;&nbsp;
        -enableThreadSanitizer
        YES|NO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        turn the thread sanitizer on or off<br />&nbsp;&nbsp;&nbsp;
        -enableUndefinedBehaviorSanitizer
        YES|NO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        turn the undefined behavior sanitizer on or off<br />&nbsp;&nbsp;&nbsp;
        -resultBundlePath
        PATH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies the directory where a result bundle describing what occurred
        will be placed<br />&nbsp;&nbsp;&nbsp; -resultStreamPath
        PATH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies the file where a result stream will be written to (the file
        must already exist)<br />&nbsp;&nbsp;&nbsp; -resultBundleVersion 3
        [default]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies which result bundle version should be used<br />&nbsp;&nbsp;&nbsp;
        -clonedSourcePackagesDirPath
        PATH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies the directory to which remote source packages are fetch or
        expected to be found<br />&nbsp;&nbsp;&nbsp; -derivedDataPath
        PATH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies the directory where build products and other derived data will
        go<br />&nbsp;&nbsp;&nbsp; -archivePath
        PATH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies the directory where any created archives will be placed, or
        the archive that should be exported<br />&nbsp;&nbsp;&nbsp;
        -exportArchive&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies that an archive should be exported<br />&nbsp;&nbsp;&nbsp;
        -exportNotarizedApp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        export an archive that has been notarized by Apple<br />&nbsp;&nbsp;&nbsp;
        -exportOptionsPlist
        PATH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies a path to a plist file that configures archive exporting<br />&nbsp;&nbsp;&nbsp;
        -enableCodeCoverage
        YES|NO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        turn code coverage on or off when testing<br />&nbsp;&nbsp;&nbsp;
        -exportPath
        PATH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies the destination for the product exported from an archive<br />&nbsp;&nbsp;&nbsp;
        -skipUnavailableActions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies that scheme actions that cannot be performed should be skipped
        instead of causing a failure<br />&nbsp;&nbsp;&nbsp;
        -exportLocalizations&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        exports completed and outstanding project localizations<br />&nbsp;&nbsp;&nbsp;
        -importLocalizations&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        imports localizations for a project, assuming any necessary localized
        resources have been created in Xcode<br />&nbsp;&nbsp;&nbsp;
        -localizationPath&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies a path to XLIFF localization files<br />&nbsp;&nbsp;&nbsp;
        -exportLanguage&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies multiple optional ISO 639-1 languages included in a
        localization export<br />&nbsp;&nbsp;&nbsp;
        -defaultLanguage&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies the default ISO 639-1 language to be used as the source
        language on export<br />&nbsp;&nbsp;&nbsp;
        -xctestrun&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies a path to a test run specification<br />&nbsp;&nbsp;&nbsp;
        -testProductsPath&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies a path for the test products<br />&nbsp;&nbsp;&nbsp;
        -enablePerformanceTestsDiagnostics
        YES|NO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        enables performance trace and memgraph collection for performance
        XCTests<br />&nbsp;&nbsp;&nbsp;
        -testPlan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies the name of the test plan associated with the scheme to use
        for testing<br />&nbsp;&nbsp;&nbsp;
        -only-testing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        constrains testing by specifying tests to include, and excluding other
        tests<br />&nbsp;&nbsp;&nbsp;
        -only-testing:TEST-IDENTIFIER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        constrains testing by specifying tests to include, and excluding other
        tests<br />&nbsp;&nbsp;&nbsp;
        -skip-testing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        constrains testing by specifying tests to exclude, but including other
        tests<br />&nbsp;&nbsp;&nbsp;
        -skip-testing:TEST-IDENTIFIER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        constrains testing by specifying tests to exclude, but including other
        tests<br />&nbsp;&nbsp;&nbsp; -test-timeouts-enabled
        YES|NO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        enable or disable test timeout behavior<br />&nbsp;&nbsp;&nbsp;
        -default-test-execution-time-allowance
        SECONDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the
        default execution time an individual test is given to execute, if test
        timeouts are enabled<br />&nbsp;&nbsp;&nbsp;
        -maximum-test-execution-time-allowance
        SECONDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the
        maximum execution time an individual test is given to execute,
        regardless of the test's preferred allowance<br />&nbsp;&nbsp;&nbsp;
        -test-iterations
        &lt;number&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        If specified, tests will run &lt;number&gt; times. May be used in
        conjunction with either -retry-tests-on-failure or
        -run-tests-until-failure, in which case this will become the maximum
        number of iterations.<br />&nbsp;&nbsp;&nbsp;
        -retry-tests-on-failure&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        If specified, tests will retry on failure. May be used in conjunction
        with -test-iterations &lt;number&gt;, in which case &lt;number&gt; will
        be the maximum number of iterations. Otherwise, a maximum of 3 is
        assumed. May not be used with -run-tests-until-failure.<br />&nbsp;&nbsp;&nbsp;
        -run-tests-until-failure&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        If specified, tests will run until they fail. May be used in conjunction
        with -test-iterations &lt;number&gt;, in which case &lt;number&gt; will
        be the maximum number of iterations. Otherwise, a maximum of 100 is
        assumed. May not be used with -retry-tests-on-failure.<br />&nbsp;&nbsp;&nbsp;
        -test-repetition-relaunch-enabled
        YES|NO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Enable or disable, tests repeating in a new process for each
        repetition.&nbsp; Must be used in conjunction with -test-iterations,
        -retry-tests-on-failure, or -run-tests-until-failure. If not specified,
        tests will repeat in the same process.<br />&nbsp;&nbsp;&nbsp;
        -only-test-configuration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        constrains testing by specifying test configurations to include, and
        excluding other test configurations<br />&nbsp;&nbsp;&nbsp;
        -skip-test-configuration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        constrains testing by specifying test configurations to exclude, but
        including other test configurations<br />&nbsp;&nbsp;&nbsp;
        -collect-test-diagnostics
        on-failure|never&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Whether or not testing collects verbose diagnostics (like a sysdiagnose)
        when encountering a failure<br />&nbsp;&nbsp;&nbsp;
        -testLanguage&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        constrains testing by specifying ISO 639-1 language in which to run the
        tests<br />&nbsp;&nbsp;&nbsp;
        -testRegion&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        constrains testing by specifying ISO 3166-1 region in which to run the
        tests<br />&nbsp;&nbsp;&nbsp;
        -enumerate-tests&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Enumerate the tests that would be executed by this command without
        actually executing them<br />&nbsp;&nbsp;&nbsp;
        -test-enumeration-style&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        The style in which to enumerate the tests. Valid styles: flat,
        hierarchical<br />&nbsp;&nbsp;&nbsp;
        -test-enumeration-format&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        The output format of the enumerated tests. Valid formats: text, json<br />&nbsp;&nbsp;&nbsp;
        -test-enumeration-output-path&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        The path (relative or absolute) where the results of test enumeration
        should be written. If '-' is supplied, writes to standard out.<br />&nbsp;&nbsp;&nbsp;
        -resolvePackageDependencies&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        resolves any Swift package dependencies referenced by the project or
        workspace<br />&nbsp;&nbsp;&nbsp;
        -disableAutomaticPackageResolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        prevents packages from automatically being resolved to versions other
        than those recorded in the `Package.resolved` file<br />&nbsp;&nbsp;&nbsp;
        -onlyUsePackageVersionsFromResolvedFile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        prevents packages from automatically being resolved to versions other
        than those recorded in the `Package.resolved` file<br />&nbsp;&nbsp;&nbsp;
        -skipPackageUpdates&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Skip updating package dependencies from their remote<br />&nbsp;&nbsp;&nbsp;
        -disablePackageRepositoryCache&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        disable use of a local cache of remote package repositories<br />&nbsp;&nbsp;&nbsp;
        -skipPackagePluginValidation&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Skip validation of package plugins (this can be a security risk if they
        are not from trusted sources)<br />&nbsp;&nbsp;&nbsp;
        -skipMacroValidation&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Skip validation of macros (this can be a security risk if they are not
        from trusted sources)<br />&nbsp;&nbsp;&nbsp;
        -packageCachePath&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        path of caches used for package support<br />&nbsp;&nbsp;&nbsp;
        -defaultPackageRegistryURL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        URL of the default package registry<br />&nbsp;&nbsp;&nbsp;
        -packageDependencySCMToRegistryTransformation&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies the transformation to apply to SCM-based package dependencies
        (none, useRegistryIdentity, or useRegistryIdentityAndSources)<br />&nbsp;&nbsp;&nbsp;
        -skipPackageSignatureValidation&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Skip validation of package signatures (this can be a security risk if
        they are not from trusted sources)<br />&nbsp;&nbsp;&nbsp;
        -packageFingerprintPolicy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Package fingerprint checking policy (`warn` or `strict`)<br />&nbsp;&nbsp;&nbsp;
        -packageSigningEntityPolicy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Package signing entity checking policy (`warn` or `strict`)<br />&nbsp;&nbsp;&nbsp;
        -json&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        output as JSON (note: -json implies -quiet)<br />&nbsp;&nbsp;&nbsp;
        -allowProvisioningUpdates&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Allow xcodebuild to communicate with the Apple Developer website. For
        automatically signed targets, xcodebuild will create and update
        profiles, app IDs, and certificates. For manually signed targets,
        xcodebuild will download missing or updated provisioning profiles.
        Requires a developer account to have been added in Xcode's Accounts
        settings or an App Store Connect authentication key to be specified via
        the -authenticationKeyPath, -authenticationKeyID, and
        -authenticationKeyIssuerID parameters.<br />&nbsp;&nbsp;&nbsp;
        -allowProvisioningDeviceRegistration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Allow xcodebuild to register your destination device on the developer
        portal if necessary. This flag only takes effect if
        -allowProvisioningUpdates is also passed.<br />&nbsp;&nbsp;&nbsp;
        -authenticationKeyPath&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies the path to an authentication key issued by App Store Connect.
        If specified, xcodebuild will authenticate with the Apple Developer
        website using this credential. The -authenticationKeyID and
        -authenticationKeyIssuerID parameters are required.<br />&nbsp;&nbsp;&nbsp;
        -authenticationKeyID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies the key identifier associated with the App Store Conect
        authentication key at -authenticationKeyPath. This string can be located
        in the users and access details for your provider at
        "https://appstoreconnect.apple.com".<br />&nbsp;&nbsp;&nbsp;
        -authenticationKeyIssuerID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        specifies the App Store Connect issuer identifier associated with the
        authentication key at -authenticationKeyPath. This string can be located
        in the users and access details for your provider at
        "https://appstoreconnect.apple.com".<br />&nbsp;&nbsp;&nbsp;
        -scmProvider&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        which implementation to use for Git operations (system/xcode)<br />&nbsp;&nbsp;&nbsp;
        -showBuildTimingSummary&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        display a report of the timings of all the commands invoked during the
        build<br />&nbsp;&nbsp;&nbsp;
        -create-xcframework&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        create an xcframework from prebuilt libraries; -help for more
        information.<br /><br />Available keys for -exportOptionsPlist:<br /><br />&nbsp;&nbsp;
        &nbsp;compileBitcode : Bool<br /><br />&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
        &nbsp;For non-App Store exports, should Xcode re-compile the app from
        bitcode? Defaults to YES.<br /><br />&nbsp;&nbsp; &nbsp;destination :
        String<br /><br />&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;Determines
        whether the app is exported locally or uploaded to Apple. Options are
        export or upload. The available options vary based on the selected
        distribution method. Defaults to export.<br /><br />&nbsp;&nbsp;
        &nbsp;distributionBundleIdentifier : String<br /><br />&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp; &nbsp;Reformat archive to focus on eligible target
        bundle identifier. Defaults to top level bundle identifier.<br /><br />&nbsp;&nbsp;
        &nbsp;embedOnDemandResourcesAssetPacksInBundle : Bool<br /><br />&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp; &nbsp;For non-App Store exports, if the app uses On
        Demand Resources and this is YES, asset packs are embedded in the app
        bundle so that the app can be tested without a server to host asset
        packs. Defaults to YES unless onDemandResourcesAssetPacksBaseURL is
        specified.<br /><br />&nbsp;&nbsp; &nbsp;generateAppStoreInformation :
        Bool<br /><br />&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;For App Store
        exports, should Xcode generate App Store Information for uploading with
        iTMSTransporter? Defaults to NO.<br /><br />&nbsp;&nbsp;
        &nbsp;iCloudContainerEnvironment : String<br /><br />&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp; &nbsp;If the app is using CloudKit, this configures
        the "com.apple.developer.icloud-container-environment" entitlement.
        Available options vary depending on the type of provisioning profile
        used, but may include: Development and Production. If not specified,
        this defaults to Development when development signing or Production when
        distribution signing<br /><br />&nbsp;&nbsp;
        &nbsp;installerSigningCertificate : String<br /><br />&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp; &nbsp;For manual signing only. Provide a certificate
        name, SHA-1 hash, or automatic selector to use for signing. Automatic
        selectors allow Xcode to pick the newest installed certificate of a
        particular type. The available automatic selectors are "Developer ID
        Installer" and "Mac Installer Distribution". Defaults to an automatic
        certificate selector matching the current distribution method.<br /><br />&nbsp;&nbsp;
        &nbsp;manageAppVersionAndBuildNumber : Bool<br /><br />&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp; &nbsp;Should Xcode manage the app's build number when
        uploading to App Store Connect? Defaults to YES.<br /><br />&nbsp;&nbsp;
        &nbsp;manifest : Dictionary<br /><br />&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
        &nbsp;For non-App Store exports, users can download your app over the
        web by opening your distribution manifest file in a web browser. To
        generate a distribution manifest, the value of this key should be a
        dictionary with three sub-keys: appURL, displayImageURL,
        fullSizeImageURL. The additional sub-key assetPackManifestURL is
        required when using on-demand resources.<br /><br />&nbsp;&nbsp;
        &nbsp;method : String<br /><br />&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
        &nbsp;Describes how Xcode should export the archive. Available options:
        app-store-connect, release-testing, enterprise, debugging, developer-id,
        mac-application, validation, and package. The list of options varies
        based on the type of archive. Defaults to debugging. Additional options
        include app-store (deprecated: use app-store-connect), ad-hoc
        (deprecated: use release-testing), and development (deprecated: use
        debugging).<br /><br />&nbsp;&nbsp;
        &nbsp;onDemandResourcesAssetPacksBaseURL : String<br /><br />&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp; &nbsp;For non-App Store exports, if the app uses On
        Demand Resources and embedOnDemandResourcesAssetPacksInBundle isn't YES,
        this should be a base URL specifying where asset packs are going to be
        hosted. This configures the app to download asset packs from the
        specified URL.<br /><br />&nbsp;&nbsp; &nbsp;provisioningProfiles :
        Dictionary<br /><br />&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;For manual
        signing only. Specify the provisioning profile to use for each
        executable in your app. Keys in this dictionary are the bundle
        identifiers of executables; values are the provisioning profile name or
        UUID to use.<br /><br />&nbsp;&nbsp; &nbsp;signingCertificate :
        String<br /><br />&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;For manual
        signing only. Provide a certificate name, SHA-1 hash, or automatic
        selector to use for signing. Automatic selectors allow Xcode to pick the
        newest installed certificate of a particular type. The available
        automatic selectors are "Mac App Distribution", "iOS Distribution", "iOS
        Developer", "Developer ID Application", "Apple Distribution", "Mac
        Developer", and "Apple Development". Defaults to an automatic
        certificate selector matching the current distribution method.<br /><br />&nbsp;&nbsp;
        &nbsp;signingStyle : String<br /><br />&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
        &nbsp;The signing style to use when re-signing the app for distribution.
        Options are manual or automatic. Apps that were automatically signed
        when archived default to automatic. Apps that were manually signed when
        archived default to manual. If your archive is manually signed and you
        choose to automatically sign when distributing, then Xcode will create
        provisioning profiles and managed cloud signing certificates as
        necessary, but will not register devices, register app IDs, or modify
        app ID settings.<br /><br />&nbsp;&nbsp; &nbsp;stripSwiftSymbols :
        Bool<br /><br />&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;Should symbols be
        stripped from Swift libraries in your IPA? Defaults to YES.<br /><br />&nbsp;&nbsp;
        &nbsp;teamID : String<br /><br />&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
        &nbsp;The Developer team to use for this export. Defaults to the team
        used to build the archive.<br /><br />&nbsp;&nbsp;
        &nbsp;testFlightInternalTestingOnly : Bool<br /><br />&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp; &nbsp;When enabled, this build cannot be distributed
        via external TestFlight or the App Store. This is recommended for pull
        requests, development branches, and other builds that are not suitable
        for external distribution.<br /><br />&nbsp;&nbsp; &nbsp;thinning :
        String<br /><br />&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;For non-App
        Store exports, should Xcode thin the package for one or more device
        variants? Available options: &lt;none&gt; (Xcode produces a non-thinned
        universal app), &lt;thin-for-all-variants&gt; (Xcode produces a
        universal app and all available thinned variants), or a model identifier
        for a specific device (e.g. "iPhone7,1"). Defaults to &lt;none&gt;.<br /><br />&nbsp;&nbsp;
        &nbsp;uploadSymbols : Bool<br /><br />&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
        &nbsp;For App Store exports, should the package include symbols?
        Defaults to YES.
      </p>
      <img src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExbWF2OGZxMHhydGRycXcxY2cxOWs3cGp4MWpvY2pnazlnNndtc2xoZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/UdBN7UKNO4xRENAWMf/giphy.gif"/>
</Terminal>

---

# xcodebuild

<Terminal>
  <img src="/xcodebuild.gif"/>
</Terminal>

---

<div style="width: 100%; height: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center;">
  <h2 style="margin-bottom: 22px;">Introducing</h2>
  <h1 style="text-align: center; font-size: 100px;">xcodehero 🦸‍♂️</h1>
  <h2 style="margin-top: 22px;">github.com/tuist/xcodehero</h2>
</div>

---

# xcodehero 🦸‍♂️

1. Builds Xcode projects and workspaces
2. Uses `xcodebuild` under the hood
3. Better CLI design

---

<div style="width: 100%; height: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center;">
  <h1 style="text-align: center; font-size: 70px;">Pixels become language</h1>
</div>

---

<Actions/>

---

# Interface principles

- Use one of both of the following conventions:
  - `executable action object {...flags}`
  - `executable namespace action object {...flags}`
- Adopt conventions for flag usage
  - `--scheme/-s` over `-scheme`
- Adopt conventions for flags and arguments with similar semantics across other CLIs
  - Example: `--path` or `--verbose`
- Adopt the dash-case convention for flags
  - `--test-products-path` over `-testProductsPath` (xcodebuild)
- Avoid using flags for actions
  - `create-xcframework` over `-create-xcframework`

---

# xcodehero interface

````md magic-move
```bash
# Build a project scheme
$ xcodehero build MyProject.xcodeproj --scheme MyScheme --clean
```
```bash
# Build a project scheme
$ xcodehero build MyProject.xcodeproj --scheme MyScheme --clean

# Build all the project schemes
$ xcodehero build MyProject.xcodeproj --clean
```
```bash
# Build a project scheme
$ xcodehero build MyProject.xcodeproj --scheme MyScheme --clean

# Build all the project schemes
$ xcodehero build MyProject.xcodeproj --clean

# Build all the schemes of the project in the current directory
$ xcodehero build --clean
```
```bash
# Build a project scheme
$ xcodehero build MyProject.xcodeproj --scheme MyScheme --clean

# Build all the project schemes
$ xcodehero build MyProject.xcodeproj --clean

# Build all the schemes of the project in the current directory
$ xcodehero build --clean

# Build all the schemes of the project in the current directory without cleaning
$ xcodehero build
```
```bash
$ xcodehero build # {... build-specific flags}
$ xcodehero test # {... test-specific flags}
$ xcodehero archive # {... archive-specific flags}
$ xcodehero export # {... export-specific flags}
$ xcodehero create-xcframework # ...
$ xcodehero sign # ...

# And domain-specific commands
$ xcodehero connect certificates pull
$ xcodehero connect devices list --json
```
````
---

# Arguments, env. variables, and configuration files

- There are the **three sources of input.** Support all of them (flexibility for users.
- Be explicit about the **precedence order**. Recommended:
  - Arguments
  - Environment variables
  - Configuration files (e.g. `.xcodeherorc`)
    - Project-scoped configuration files
    - User-scoped configuration files
    - System-scoped configuration files

<br/>

---

# Arguments, env. variables, and configuration files

Using arguments
```bash
xcodehero build ./MyProject.xcodeproj --scheme MyScheme --clean
```

Using environment variables
```bash
# Using environment variables
TUIST_CLEAN=1 xcodehero build ./MyProject.xcodeproj --scheme MyScheme
```

Using configuration files
```toml
# ~/.xcodeherorc
clean = true
```

```bash
xcodehero build ./MyProject.xcodeproj --scheme MyScheme
```

<!-- Demo how XCODEHERO_CLEAN=1 can be used instead of clean -->

---

# Path and working directory 📂

- Don't assume in your logic paths are relative to the working directory
- Default to the current directory and allow changing it with the `--path` flag
- Pass that information down to the lowest level of your codebase

<br/>

#### Convert it to absolute as early as possible

```swift
@Argument(
    help: "The path to the workspace or project. When not passed, it defaults to any workspace or project in the current directory.",
    completion: .file(),
    transform: { try AbsolutePath.init(validating: $0, relativeTo: .currentWorkingDirectory) }
)
var path: AbsolutePath?
```

---

# Interactive environments

- Can be leveraged to gather input from the user interactively
- Not all the environments are interactive (e.g. CI/CD)
- Run the interactive experiences as early as possible

<br/>

```sh
$ Which scheme from the workspace xcodehero.xcworkspace would you like to build?

> 1. xcodehero
  2. xcodeheroTests
  3. xcodeheroAcceptanceTests
```

```sh
$ The scheme "xcodehro" doesn't exist. Did you mean "xcodehero"? (y/n)
```

---

# Architecture and code patterns 👩‍💻

- Avoid bash-like logic style (i.e. top-to-bottom one line after the other)
- Model your domain space (e.g. `XcodeProject`, `Destination`)
- Validate input to minimize validations deep in the code
- Abstract the contract with I/O sources (e.g. `FileSystem`, `StandardOutput`)

<!-- Show the architecture of xcodehero -->

---

# Logging 📝

- It's hard. Very hard. You can easily end up with a mess
- Allow users to control the verbosity level (e.g. `--verbose` or `VERBOSE=1`)
- Allow users to output verbose logs to a file (e.g. `--log-file`)
- Use standard output and standard error streams correctly
- Use colors to create visual hierarchies
- Support `--json` or `--machine-output` for in pipable comamnds
- Output the right amount of information (not too much, not too little)
- Capture and output the important information at the end (errors, warnings, summary)

<!-- Show the build of xcodehero -->

---

# Error handling 🐛

- Errors should be clear and concise when presented (what happened?)
- Errors should also be actionable (what do I do now?)
- Errors should not leak implementation details
- You might consider using error tracking platforms
  - But their SDKs might output logs to standard output

<!-- Show examples of a well and badly-formatted error messages -->

---

# Testing ✅

- Unit tests are great, but integration and acceptance tests are even better
- Avoid state sharing between tests to allow **parallelization without flakiness**
  - Leverage dependency injection down to the lowest level
- Isolate at the system level using **temporary directories**
- Have fixtures that model various input states
- Test against every supported platform
  - Especially with Swift


---

<h1>Test parallelization</h1>
<div style="display: flex; justify-content: center; align-items: center;">
  <img style="width: 70%" src="/acceptance-tests-state.png"/>
</div>


<!-- Show an acceptance test -->

---

# Extensibility 🧩

- Make sure it's clear **what the tool is and what is not.**
  - Don't try to be everything to everyone
- Identify extension points **whose interfaces are stable and add extensibility.** But note:
  - Swift limits the extensibility options
  - You can use system processes for that
  - Hashicorp workarounded the same limitation in Go with [go-plugin](https://github.com/hashicorp/go-plugin)
- For further extensibility, layer your software, and let others build on top of it.
  - For example `TuistGenerator` in [Tuist](https://tuist.io)

---

# Release and distribution 📦

- Don't compile on the user's machine (slow and error prone). 
  - Compile on CI and include the binaries on GitHub releases
  - A binary per architecture and platform (triple)
  - Define a naming convention (e.g., `{name}-{version}-{platform}-{arch}`)
- Distribute a static binary (fast launch times) unless you need to ship dynamic libraries
- Include checksums (e.g., SHA256) to ensure the integrity of the binaries
- Leverage community tools for distribution (e.g. [Mise](https://mise.jdx.dev/) or [Homebrew](https://mise.jdx.dev/))
- Notarize the binaries (macOS)

---

# GitHub release artifacts

<img class="artifacts" src="/mise-release-artifacts.png" alt="An image that shows a list of artifacts in a Mise release"/>

<style>
.artifacts {
  height: 70%;
}
</style>

---

# Version determinism across environments

- Ensuring every environment has the same version of a tool is generally a great idea
- Doing so is not one of Homebrew's strengths
- There are software installers and version managers like [Mise](https://mise.jdx.dev/) that can help
- Mise can scope versions to **a project, a user, or the system**

<br/>

```shell
mise install xcodehero            # Install the current version specified in .tool-versions/.mise.toml
mise install xcodehero@x.y.z      # Install a specific version number
mise install xcodehero@3          # Install a fuzzy version number

mise use xcodehero@x.y.z          # Use xcodehero-x.y.z in the current project
mise use xcodehero@latest         # Use the latest xcodehero in the current directory
mise use -g xcodehero@x.y.z       # Use xcodehero-x.y.z as the global default
mise use -g xcodehero@system      # Use the system's xcodehero as the global default
```

---

# Summing it up

- Building a CLI is easy. Buiding a great CLI takes a lot of **attention to detail**
- Terminals are a constrained environment. But you can still provide a **great developer experience**
- UI design in CLIs is more about **language design** than visual design (command names, output messages)
- Architect your code for **maintainability, readability, and testability.**
- Acceptance tests that are fast and easy to maintain is possible and strongly recommended


---

# One more thing... SwiftTerminal
github.com/tuist/SwiftTerminal

### A themable design system for building interactive CLIs in Swift

<br/>

<img src="/swift-terminal-1.gif"/>

---

# Grazie 😀

---

