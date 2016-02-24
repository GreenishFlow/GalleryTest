Test gallery on AS3 using BRIC algorithm.

Additional tasks:
- xmlData.children().(@myVal % 2 && trace(@myVal)); - .() is running in each XMLList element that is a result from children(). That whould add all odd values in the trace cause it will be true condition. I was used it in the test project, but just for showing how it works. I'm not a fan of this, cause this is a feature that was designed for the filtration XMLList.

- Write method that takes two sorted arrays of integers:
public function merge(a:Array , b:Array):Array {
    var answer:Array = new Array(a.length+b.length);
    var i:int = a.length - 1;
    var j:int = b.length - 1;
    var k:int = answer.length;

    while (k > 0) {
        answer[--k] = (j < 0 || (i >= 0 && a[i] >= b[j])) ? a[i--] : b[j--];
    }
    return answer;
}
