/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.models.vo {
import flash.display.Bitmap;

public class SmartGalleryVO {
    private var _replaceId:int;
    private var _items:Vector.<Bitmap>;

    public function get replaceId():int {
        return _replaceId;
    }

    public function set replaceId(value:int):void {
        _replaceId = value;
    }

    public function get items():Vector.<Bitmap> {
        return _items;
    }

    public function set items(value:Vector.<Bitmap>):void {
        _items = value;
    }
}
}
