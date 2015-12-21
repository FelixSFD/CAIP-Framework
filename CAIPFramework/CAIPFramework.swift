//
//  CAIPFramework.swift
//  CAIPFramework
//
//  Created by Felix Deil on 21.12.15.
//  Copyright © 2015 University Augsburg. All rights reserved.
//

import Foundation


// - MARK: IPv4-Class
/**
Defines an IPv4-address
- since: 1.0
- author: Felix Deil
*/
@objc public class IPv4:NSObject {
    // - MARK: Properties
    private var address:[Int] = [0, 0, 0, 0]
    
    // - MARK: Initializers
    /**
    Initialize an IPv4-address by a list of Integers
    - since: 1.0
    - author: Felix Deil
    */
    init(withSegments segment1:Int, segment2:Int, segment3:Int, segment4:Int) {
        self.address = Array.init(arrayLiteral: segment1%256, segment2%256, segment3%256, segment4%256)
    }
    
    /**
     Initialize an IPv4-address with a string
     - parameter string: The IP as string. For example `127.0.0.1`
     - since: 1.0
     - author: Felix Deil
     */
    init(withString string:String) {
        let tmpArray = string.componentsSeparatedByString(".")
        for (var i:Int = 0; i < tmpArray.count; i++) {
            self.address[i] = Int.init(tmpArray[i])!%256
        }
    }
    
    /**
     Initialize an IPv4-address with an IPv4-object
     - parameter ip: The IPv4-object
     - since: 1.0
     - author: Felix Deil
     */
    init(withIP ip:IPv4) {
        self.address = ip.asArray()
    }
    
    
    // - MARK: Return IP
    /**
    Returns the IPv4-address as string
    - since: 1.0
    - author: Felix Deil
    */
    public func asString() -> String {
        return String.init(format: "%i.%i.%i.%i", self.address[0], self.address[1], self.address[2], self.address[3])
    }
    
    /**
     Returns the IPv4-address as [Int]
     - since: 1.0
     - author: Felix Deil
     */
    public func asArray() -> [Int] {
        return self.address
    }
    
    // - MARK: Compare IPs
    /**
    Compares the IP to another IP
    */
    public func isHigherThanIP(ip:IPv4) -> Bool{
        let otherIParray:[Int] = ip.asArray()
        
        for (var i:Int = 0; i < self.address.count; i++) {
            if (self.address[i] < otherIParray[i]) {
                return false
            }
        }
        return true
    }
    
    /**
     Compares the IP to another IP
     */
    public func isLowerThanIP(ip:IPv4) -> Bool{
        let otherIParray:[Int] = ip.asArray()
        
        for (var i:Int = 0; i < self.address.count; i++) {
            if (self.address[i] > otherIParray[i]) {
                return false
            }
        }
        return true
    }
    
    /**
     Compares the IP to another IP
     */
    public func isEqualToIP(ip:IPv4) -> Bool{
        let otherIParray:[Int] = ip.asArray()
        
        for (var i:Int = 0; i < self.address.count; i++) {
            if (self.address[i] != otherIParray[i]) {
                return false
            }
        }
        return true
    }
}


// - MARK: IPv4Range-Class
/**
Defines a range of IPs (IPv4 only!)

You need to initialize this with the start- and the end-IP

- since: 1.0
- author: Felix Deil
- seealso: IPv4
*/
@objc public class IPv4Range:NSObject {
    // - MARK: Properties
    private var startIP:IPv4 = IPv4(withString: "0.0.0.0")
    private var endIP:IPv4 = IPv4(withString: "255.255.255.255")
    
    // - MARK: Initializers
    init(start:IPv4, end:IPv4) {
        if start.isLowerThanIP(end) {
            self.startIP = start
            self.endIP = end
        } else {
            self.startIP = end
            self.endIP = start
        }
    }
    
    // - MARK: Setters
    public func setStartIP(ip:IPv4) {
        self.startIP = ip
    }
    
    public func setEndIP(ip:IPv4) {
        self.endIP = ip
    }
    
    // - MARK: Comparing IPs with range
    /**
    Checks whether the IP is in this IP-range
    - parameter ip: The IP to check
    - returns: `true` if the IP is in the IPv4Range
    - since: 1.0
    */
    public func isInRange(ip:IPv4) -> Bool {
        if (ip.isHigherThanIP(self.startIP) && ip.isLowerThanIP(endIP)) || ip.isEqualToIP(startIP) || ip.isEqualToIP(endIP) {
            return true
        }
        return false
    }
}
