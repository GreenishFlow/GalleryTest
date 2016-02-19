/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.views.mediators {

import com.greenish.gallery.events.SmartGalleryEvent;
import com.greenish.gallery.events.TreeCreatorEvent;
import com.greenish.gallery.views.components.GalleryView;
import org.robotlegs.mvcs.Mediator;

/**
 * Main mediator
 */

public class GalleryViewMediator extends Mediator {
    [Inject]
    public var galleryView:GalleryView;

    public function GalleryViewMediator() {
        super();
    }

    /**
     * Reister events
     */
    override public function onRegister():void
    {
        //when user click some image
        eventMap.mapListener( galleryView, SmartGalleryEvent.IMAGE_SELECTED, onImageSelected );
        //when tree were created
        eventMap.mapListener( eventDispatcher, TreeCreatorEvent.COMPLETE, onTreeCreated );
    }

    /**
     * Send event to run ReplaceSelectedImageCommand
     * @param event
     */
    protected function onImageSelected(event:SmartGalleryEvent):void
    {
        eventDispatcher.dispatchEvent(new SmartGalleryEvent(SmartGalleryEvent.IMAGE_SELECTED, event.id));
    }

    /**
     * Update view
     * @param event
     */
    protected function onTreeCreated(event:TreeCreatorEvent):void
    {
        galleryView.dataProvider = event.data;
    }
}
}
