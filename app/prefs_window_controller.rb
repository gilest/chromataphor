class PrefsWindowController < NSWindowController

  def init
    # create the prefs window
    super.tap do 
      self.window = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
        styleMask: NSTitledWindowMask|NSClosableWindowMask,
        backing: NSBackingStoreBuffered,
        defer: true)
      self.window.setReleasedWhenClosed(false)
      self.window.delegate = self
      self.window.title = "#{@appName} Preferences"
    end
  end

  def show
    self.window.makeKeyAndOrderFront(self)
    NSApp.activateIgnoringOtherApps(true)
  end

end