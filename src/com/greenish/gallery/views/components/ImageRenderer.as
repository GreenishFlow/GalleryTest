/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.views.components {
import com.greenish.gallery.events.SmartGalleryEvent;
import com.greenish.gallery.models.vo.TreeNodeVO;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import gs.TweenLite;

/**
 * Holder for image.
 */

public class ImageRenderer extends Sprite {
    private var _id:int;
    private var _empty:Boolean=false;
    private var _bounds:Rectangle;
    public function ImageRenderer(vo:TreeNodeVO) {
        super();
        //hide it for beginning
        alpha=0;
        //setting up the renderer with data from VO
        _id=vo.id;
        addChild(vo.img);
        //set it to appropriate position and size
        vo.img.x=vo.x;
        vo.img.y = vo.y;
        vo.img.width=vo.totalWidth;
        vo.img.height = vo.totalHeight;

        //save image bounds for next animation
        setNewBounds(vo.img);
        //animate fade in with random delay to make it funny
        TweenLite.to(this,Math.random()*0.5,{alpha:1,delay:Math.random()*0.3});
        //click listener
        addEventListener(MouseEvent.CLICK, onClicked);
    }

    /**
     * Changing data for renderer.
     * If this is not empty image (so it shouldn't be replaced) we move it to appropriate position and size.
     * If it's an empty one, we should set new data and animate from old bounds to new one
     * @param vo
     */
    public function changeData(vo:TreeNodeVO):void {
        if (_empty) {
            addChild(vo.img);
            vo.img.x=_bounds.x;
            vo.img.y = _bounds.y;
            vo.img.width=_bounds.width;
            vo.img.height = _bounds.height;
            TweenLite.to(this,0.5,{alpha:1});
        }
        TweenLite.to(vo.img,0.5,{x:vo.x,y:vo.y,width:vo.totalWidth,height:vo.totalHeight,onComplete:setNewBounds,onCompleteParams:[vo.img]});
        //and now it's not empty
        _empty=false;
    }

    /**
     * Getter for image ID
     */
    public function get id():int {
        return _id;
    }
    /**
     * Click listener
     * @param event
     */
    private function onClicked(event:MouseEvent):void {
        //set it as empty
        _empty=true;
        //animate fade out
        TweenLite.to(this,0.5,{alpha:0,onComplete:onRemoved});

    }

    /**
     * When the image faded out we should send event to mediator to start replacing
     */
    private function onRemoved():void {

        dispatchEvent(new SmartGalleryEvent(SmartGalleryEvent.IMAGE_SELECTED,id));
    }

    /**
     * Just set new bounds of the image
     * @param img
     */
    private function setNewBounds(img:Bitmap):void {
        _bounds = img.getBounds(this);
    }



}
}
