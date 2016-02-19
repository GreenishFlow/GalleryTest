/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.events {
import flash.events.Event;

public class SmartGalleryEvent extends Event {
    public static const IMAGE_SELECTED:String="image selected SmartGalleryEvent";
    private var _id:Number;

    public function SmartGalleryEvent(type:String,id:Number) {
        _id=id;
        super(type, true, true);
    }

    public function get id():Number {
        return _id;
    }
}
}
