/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.controller {
import com.greenish.gallery.interfaces.ILoaderService;
import com.greenish.gallery.views.components.GalleryView;
import org.robotlegs.mvcs.Command;

/**
 * Standart Robotlegs startup command
 */
public class StartupCommand extends Command {

    [Inject]
    public var service:ILoaderService;

    /**
     * method adds the view component and start to load first images
     */
    override public function execute ():void
    {
        contextView.addChild(new GalleryView());
        service.load();
    }
}
}
