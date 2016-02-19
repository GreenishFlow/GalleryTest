/**
 * Created by evgeny on 18.02.16.
 */
package com.greenish.gallery.events {


import com.greenish.gallery.models.vo.SmartGalleryVO;

import flash.events.Event;

public class DataLoaderEvent extends Event {
    public static const DATA_COMPLETE:String = "onDataComplete DataLoaderEvent";


    private var _vo:SmartGalleryVO;
    public function DataLoaderEvent(type:String, vo:SmartGalleryVO=null) {
        _vo=vo;
        super(type, false, true);
    }

    public function get vo():SmartGalleryVO {
        return _vo;
    }

}
}
