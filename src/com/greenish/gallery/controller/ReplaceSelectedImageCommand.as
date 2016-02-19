/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.controller {
import com.greenish.gallery.events.SmartGalleryEvent;
import com.greenish.gallery.interfaces.ILoaderService;
import org.robotlegs.mvcs.Command;

/**
 * Command to start replacing the photo. Runs from mediator, when user click some photo
 */
public class ReplaceSelectedImageCommand extends Command {
    [Inject]
    public var event:SmartGalleryEvent;
    [Inject]
    public var service:ILoaderService;

    override public function execute():void
    {
        service.replacePhoto(event.id);
    }
}
}
