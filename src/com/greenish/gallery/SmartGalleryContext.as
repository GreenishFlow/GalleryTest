/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery {
import com.greenish.gallery.controller.ReplaceSelectedImageCommand;
import com.greenish.gallery.controller.TreeCreatedCommand;
import com.greenish.gallery.controller.UpdatePhotosCommand;
import com.greenish.gallery.controller.StartupCommand;
import com.greenish.gallery.events.DataLoaderEvent;
import com.greenish.gallery.events.SmartGalleryEvent;
import com.greenish.gallery.events.TreeCreatorEvent;
import com.greenish.gallery.interfaces.ICreatorService;
import com.greenish.gallery.interfaces.ILoaderService;
import com.greenish.gallery.models.SmartGalleryModel;
import com.greenish.gallery.services.locals.TreeCreatorService;
import com.greenish.gallery.services.remote.ImageLoaderService;
import com.greenish.gallery.views.components.GalleryView;
import com.greenish.gallery.views.mediators.GalleryViewMediator;
import flash.display.DisplayObjectContainer;
import org.robotlegs.base.ContextEvent;
import org.robotlegs.mvcs.Context;

/**
 * Robotlegs standart context
 */
public class SmartGalleryContext extends Context {


    public function SmartGalleryContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true) {
        super(contextView, autoStartup);
    }
    override public function startup():void
    {
        //map controller
        commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartupCommand, ContextEvent);
        commandMap.mapEvent(DataLoaderEvent.DATA_COMPLETE, UpdatePhotosCommand, DataLoaderEvent);
        commandMap.mapEvent(SmartGalleryEvent.IMAGE_SELECTED, ReplaceSelectedImageCommand, SmartGalleryEvent);
        commandMap.mapEvent(TreeCreatorEvent.COMPLETE, TreeCreatedCommand, TreeCreatorEvent);

        //map model
        injector.mapSingleton( SmartGalleryModel );

        //map services
        injector.mapSingletonOf( ILoaderService, ImageLoaderService );
        injector.mapSingletonOf( ICreatorService, TreeCreatorService );

        //map view
        mediatorMap.mapView(GalleryView, GalleryViewMediator);

        super.startup();
    }
}
}
