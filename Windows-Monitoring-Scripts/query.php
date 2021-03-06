<?php
/*****************************************************************************************
 * 									Smart Panel CFX
 * You may edit the files and you may use this software as a commercial company.
 * You may NOT release your own version of this software at any given time!
 * This software belongs to its perspective person and addionally software to their own.
 * 								   - www.realchamp.dk -
 * This software is free. And you may install it as many times as you want. 
 * There are NO bindings. However we'd appreciate your feedbacks at our forums.
 * 					You will find it here http://forums.realchamp.dk.
 *					     Smart Panel CFX © www.realchamp.dk 2009
 *****************************************************************************************
*/
// CODE...
  function query_source($address)
  {
    $array = explode(":", $address);

    $server['status'] = 0;
    $server['ip']     = $array[0];
    $server['port']   = $array[1];

    if (!$server['ip'] || !$server['port']) { exit("EMPTY OR INVALID ADDRESS"); }

    $socket = @fsockopen("udp://{$server['ip']}", $server['port'], $errno, $errstr, 1);

    if (!$socket) { return $server; }

    stream_set_timeout($socket, 1);
    stream_set_blocking($socket, TRUE);
    $beforeTime = time();
    fwrite($socket, "\xFF\xFF\xFF\xFF\x54Source Engine Query\x00");
    $packet = fread($socket, 4096);
    $afterTime = time();
    @fclose($socket);

    if (!$packet) { return $server; }

    $header                = substr($packet, 0, 4);
    $response_type         = substr($packet, 4, 1);
    $network_version       = ord(substr($packet, 5, 1));

    if ($response_type != "I") { exit("NOT A SOURCE SERVER"); }

    $packet_array          = explode("\x00", substr($packet, 6), 5);
    $server['ping']        = $afterTime - $beforeTime;
    $server['name']        = $packet_array[0];
    $server['map']         = $packet_array[1];
    $server['game']        = $packet_array[2];
    $server['description'] = $packet_array[3];
    $packet                = $packet_array[4];
    $app_id                = array_pop(unpack("S", substr($packet, 0, 2)));
    $server['players']     = ord(substr($packet, 2, 1));
    $server['playersmax']  = ord(substr($packet, 3, 1));
    $server['bots']        = ord(substr($packet, 4, 1));
    $server['status']      = 1;
	$server['dedicated']   =     substr($packet, 5, 1); 
	$server['os']          =     substr($packet, 6, 1); 
	$server['password']    = ord(substr($packet, 7, 1)); 
	$server['vac']         = ord(substr($packet, 8, 1)); 

    return $server;
  }

?>
