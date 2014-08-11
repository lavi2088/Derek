<?php
/**
 * @title            QR Code Example
 *
 * @author           Pierre-Henry Soria <ph7software@gmail.com>
 * @copyright        (c) 2012, Pierre-Henry Soria. All Rights Reserved.
 * @license          GNU General Public License.
 */

require 'QRCode.class.php';

try
{

    /**
     * If you have PHP 5.4 or higher, you can instantiate the object like this:
     * $oQRC = (new QRCode) // Create vCard Object
     */
    $oQRC = new QRCode; // Create vCard Object
    $oQRC->fullName('tanningloft') // Add Full Name
        ->nickName('Tanning') // Add Nickname
        ->gender('M') // Add Gender
        ->email('http://tanningloft.com') // Add Email Address
        ->impp('info@tannningloft.ca') // Add Instant Messenger
        ->url('http://tanningloft.ca') // Add URL Website
        ->note('NA') // Add Note
        ->categories('voucher') // Add Categories
        ->photo('QRCode.png') // Add Avatar
        ->lang('en-US') // Add Language
        ->finish(); // End vCard

        // echo '<p><img src="' . $oQRC->get(300) . '" alt="QR Code" /></p>'; // Generate and display the QR Code
        $oQRC->display(); // Display

}
catch (Exception $oExcept)
{
    echo '<p><b>Exception launched!</b><br /><br />' .
    'Message: ' . $oExcept->getMessage() . '<br />' .
    'File: ' . $oExcept->getFile() . '<br />' .
    'Line: ' . $oExcept->getLine() . '<br />' .
    'Trace: <p/><pre>' . $oExcept->getTraceAsString() . '</pre>';
}
