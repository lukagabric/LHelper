LHelper
=======

Many useful iOS methods. I'm not going to mention them here, just check the LHelper and LHelperCategories declarations.

You may use the LHelper and LHelperCategories classes files in your project, or you may follow the steps below to clone the repo and use it as static library in your project.

Integrating into your project as static library
-----------------------------------------------

1. clone the LHelper git repository e.g. git clone git://github.com/lukagabric/LHelper.git
2. add LHelper.xcodeproj to your project, make sure "Copy items into ..." is unchecked
3. in your target's Build Phases, under Link Binary With Libraries, click on the (+) and add the libLHelper.a library, CoreGraphics.framework and QuartzCore.framework.
4. add the relative path to the LHelper and LHelperCategories headers (../LHelper/LHelper/Classes) in your "User Header Search Path" Build Setting
5. add -ObjC and -all_load to Other Linker Flags in your target's build settings
