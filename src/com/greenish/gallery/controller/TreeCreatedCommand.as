/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.controller {
import com.greenish.gallery.events.TreeCreatorEvent;
import com.greenish.gallery.models.SmartGalleryModel;

import org.robotlegs.mvcs.Command;

/**
 * Tree were created and we can add it to model
 */
public class TreeCreatedCommand extends Command {
    [Inject]
    public var event:TreeCreatorEvent;
    [Inject]
    public var model:SmartGalleryModel;

    override public function execute():void
    {
        model.nodes = event.data;

    }
}
}
