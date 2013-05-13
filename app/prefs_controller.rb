class PrefsController

  def initialize
    # create the prefs window
    @window = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: true)
    @window.setReleasedWhenClosed(false)
    @window.title = "#{@appName} Preferences"
  end

  def show
    @window.makeKeyAndOrderFront(self)
    NSApp.activateIgnoringOtherApps(true)
  end

end