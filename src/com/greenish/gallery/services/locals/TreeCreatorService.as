/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.services.locals {
import com.greenish.gallery.events.TreeCreatorEvent;
import com.greenish.gallery.interfaces.ICreatorService;
import com.greenish.gallery.models.vo.DimensionsVO;
import com.greenish.gallery.models.vo.SmartGalleryVO;
import com.greenish.gallery.models.vo.TreeNodeVO;
import flash.display.Bitmap;
import org.robotlegs.mvcs.Actor;

/**
 * Main logic for creating collage.
 * I'm using BRIC (Blocked Recursive Image Composition) algorithm to create the layout and scale the images, but here i calculate the future position of the images too.
 *
 */

public class TreeCreatorService extends Actor implements ICreatorService{
    //that is the maximum width of the layout
    private static const CONTAINER_WIDTH:Number=800;
    //should layout be horizontal or vertical
    private static const CONTAINER_HORIZONTAL:Boolean=false;

    private var _images:Vector.<TreeNodeVO>;


    public function TreeCreatorService() {
        super();
    }

    /**
     * Generate the new tree for all photos that exists in VO
     * @param vo
     */
    public function generate(vo:SmartGalleryVO):void {
        _images = new <TreeNodeVO>[];
        var node:TreeNodeVO;
        for (var i:int = 0; i < vo.items.length; i++) {
            var img:Bitmap = vo.items[i];
            node = new TreeNodeVO();
            node.x=0;
            node.y=0;
            node.id=i;
            node.img=img;
            node.totalWidth=img.width;
            node.totalHeight=img.height;
            node.isHorizontal = node.totalWidth>node.totalHeight;
            _images.push(node);
        }

        var box:TreeNodeVO = bricLayout(_images, CONTAINER_HORIZONTAL);
        var dimensions:DimensionsVO = new DimensionsVO();
        dimensions.width=CONTAINER_WIDTH;
        box = bricLayoutScaleBox(box, dimensions);
        var images:Vector.<TreeNodeVO> = new Vector.<TreeNodeVO>();
        positionLayout(box,images);

        //send the event to start
        dispatch(new TreeCreatorEvent(TreeCreatorEvent.COMPLETE,images));
    }

    /**
     * Adds new image to the tree with ID
     * @param img
     * @param toId
     */
    public function add(img:Bitmap,toId:int):void {

        var node:TreeNodeVO = _images[toId];
        node.img.bitmapData.dispose();



        node = new TreeNodeVO();
        node.id=toId;
        node.img=img;
        node.totalWidth=img.width;
        node.totalHeight=img.height;
        node.isHorizontal = node.totalWidth>node.totalHeight;
        _images[toId] = node;
        var box:TreeNodeVO = bricLayout(_images, CONTAINER_HORIZONTAL);
        var dimensions:DimensionsVO = new DimensionsVO();
        dimensions.width=CONTAINER_WIDTH;
        box = bricLayoutScaleBox(box, dimensions);
        var images:Vector.<TreeNodeVO> = new Vector.<TreeNodeVO>();
        positionLayout(box,images);
        dispatch(new TreeCreatorEvent(TreeCreatorEvent.COMPLETE,images));
    }

    /**
     * This method moves across the tree recursively and calculates the positions of each image to easy add/animate
     * Hate to have this method here. Need to calculate it in bricLayout and bricLayoutScaleBox
     *
     * @param box
     * @param images
     * @return
     */
    private function positionLayout(box:TreeNodeVO,images:Vector.<TreeNodeVO>):TreeNodeVO {
        if (!box.img) {
            if (!box.isHorizontal) {
                box.left.y=box.y;
                box.right.y=box.y+box.left.totalHeight;
                box.left.x=box.right.x=box.x;
            }
            else {
                box.left.x=box.x;
                box.right.x=box.x+box.left.totalWidth;
                box.left.y=box.right.y=box.y;
            }
            positionLayout(box.left,images);
            positionLayout(box.right,images);


        } else {
            images.push(box);
        }
        return box;
    }

    /**
     * Calculates the layout
     * @param images
     * @param isHorizontal
     * @return
     */
    private function bricLayout(images:Vector.<TreeNodeVO>, isHorizontal:Boolean):TreeNodeVO {
        var box:TreeNodeVO;
        if (images.length > 1) {
            var rightImages:Vector.<TreeNodeVO> = images.concat();
            var leftImages:Vector.<TreeNodeVO> = rightImages.splice(0, Math.floor(rightImages.length / 2));
            box = new TreeNodeVO();
            box.x=0;
            box.y=0;
            box.isHorizontal=!isHorizontal;

            box.left = bricLayout(leftImages,!isHorizontal);
            box.right = bricLayout(rightImages,!isHorizontal);

            box.left.parent = box.right.parent = box;
            var dimensions:DimensionsVO=new DimensionsVO();
            if (isHorizontal) {
                dimensions.width = box.left.totalWidth;
            } else {
                dimensions.height=box.left.totalHeight;
            }
            box.right = bricLayoutScaleBox(box.right, dimensions);
            if (isHorizontal) {
                box.totalHeight = box.left.totalHeight + box.right.totalHeight;
                box.totalWidth = box.left.totalWidth;



            } else {
                box.totalWidth = box.left.totalWidth + box.right.totalWidth;
                box.totalHeight = box.left.totalHeight;



            }
            box.left.parent.totalWidth = box.right.parent.totalWidth = box.totalWidth;
            box.left.parent.totalHeight = box.right.parent.totalHeight = box.totalHeight;
        } else if (images.length == 1) {
            box = images.pop();
        }

        return box;
    }

    /**
     * Scale all boxes to fit the dimensions
     * @param box
     * @param dimensions
     * @return
     */
    private function bricLayoutScaleBox(box:TreeNodeVO, dimensions:DimensionsVO):TreeNodeVO {
        if (box.isImage) {
            if (dimensions.width != -1) {
                box.totalHeight = (dimensions.width / box.totalWidth) * box.totalHeight;
                box.totalWidth = dimensions.width;
            }
            else if (dimensions.height != -1) {
                box.totalWidth = (dimensions.height / box.totalHeight) * box.totalWidth;
                box.totalHeight = dimensions.height;
            }
            return box;
        }
        var dimensions1:DimensionsVO;
        var dimensions2:DimensionsVO;
        if (dimensions.width != -1) {
            if (!box.isHorizontal) {
                dimensions1 = dimensions2 = dimensions;
            }
            // Horizontal box type; vertical contact.
            else {
                dimensions1 = new DimensionsVO();
                dimensions1.width = (box.left.totalWidth / (box.left.totalWidth + box.right.totalWidth)) * dimensions.width;
                dimensions2 = new DimensionsVO();
                dimensions2.width=(box.right.totalWidth / (box.left.totalWidth + box.right.totalWidth)) * dimensions.width;
            }
        }
        else if (dimensions.height != -1) {
            // Vertical box type; horizontal contact.
            if (!box.isHorizontal) {
                dimensions1 = new DimensionsVO();
                dimensions1.height=(box.left.totalHeight / (box.left.totalHeight + box.right.totalHeight)) * dimensions.height;
                dimensions2 = new DimensionsVO();
                dimensions2.height=(box.right.totalHeight / (box.left.totalHeight + box.right.totalHeight)) * dimensions.height;
            }
            // Horizontal box type; vertical contact.
            else  {
                dimensions1 = dimensions2 = dimensions;
            }
        }

        box.left = bricLayoutScaleBox(box.left, dimensions1);
        box.right = bricLayoutScaleBox(box.right, dimensions2);

        if (!box.isHorizontal) {
            box.totalHeight = box.left.totalHeight + box.right.totalHeight;
            box.totalWidth = box.left.totalWidth;

        }
        else {
            box.totalWidth = box.left.totalWidth + box.right.totalWidth;
            box.totalHeight = box.left.totalHeight;

        }

        box.left.parent.totalWidth = box.right.parent.totalWidth = box.totalWidth;
        box.left.parent.totalHeight = box.right.parent.totalHeight = box.totalHeight;



        return box;
    }


}
}
