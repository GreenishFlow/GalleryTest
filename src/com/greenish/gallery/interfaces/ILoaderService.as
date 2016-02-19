/**
 * Created by evgeny on 20.02.16.
 */
package com.greenish.gallery.interfaces {
/**
 * Interface for data and images loader service
 */
public interface ILoaderService {
    function load ():void;
    function replacePhoto (id:int):void;
}
}
