/**
 * Created by evgeny on 20.02.16.
 */
package com.greenish.gallery.interfaces {
import com.greenish.gallery.models.vo.SmartGalleryVO;
import flash.display.Bitmap;

/**
 * Interface for creating the data tree
 */
public interface ICreatorService {
    function generate(vo:SmartGalleryVO):void
    function add(img:Bitmap,toId:int):void
}
}
