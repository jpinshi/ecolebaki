<?php
session_start();
/*session_unset('uid');
session_unset('direction');
session_unset('priority');
session_unset('slices');
session_unset('1TRF');
session_unset('2TRF');
session_unset('3TRF');
session_unset('SUB');
session_unset('RESUB');
session_unset('list_current_pupils');
session_unset('counter_pupil');
session_unset('counter_agents');
session_unset('pupils');
session_unset('agents');
session_unset('list_users');
*/
session_destroy();

header('Location:login');