#!/usr/bin/perl
#
# jstest: ジョイステックのテスト
#
# cat /dev/input/js0 | ./jsdump

$js_event_len = 8;

@js_typestr = ( '未定義', 'ボタン', '軸' );

for (;;) {
  $js = '';
  do {
    $s = '';
    read ( STDIN, $s, $js_event_len );
    $js .= $s;
  } while ( length ( $js ) < $js_event_len );

  while ( length ( $js ) >= $js_event_len ) {
    ( $js_time, $js_value, $js_type, $js_number ) = unpack ( 'LsCC', $js );
    $js = substr ( $js, $js_event_len );

    $js_init  = $js_type & 0x80;
    $js_mtype = $js_type & 0x7f;

    print "時刻: $js_time\n";
    print "値:   $js_value\n";
    print "種類: $js_type (";
    if ( $js_init ) {
      print "初期化/";
    }
    print $js_typestr[$js_mtype], ")\n";
    print "番号: $js_number\n\n";
  }
}
