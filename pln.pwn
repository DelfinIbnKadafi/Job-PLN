#include <a_samp>
#include <zcmd>

new Float: X[5];
new Float: Y[5];
new Float: Z[5];

forward OnPerbaikiListrik(playerid);

new duty{MAX_PLAYERS];

#define filterscript

public OnFilterScriptInit() {
  print("Job pln berhasil dimuat");
  return 0;
}

CMD:dutypln(playerid) {
  if(duty[playerid] == 0) {
    SendClientMessage(playerid, -1, "Kamu telah duty pln");
    duty[playerid] = 1;
  }
  else {
    SendClientMessage(playerid, -1, "Kamu telah off duty pln");
    duty[playerid] = 0;
  }
  return 1;
}

public OnPerbaikiListrik(playerid) {
  SendClientMesage(playerid, -1, "Berhasil memperbaiki listrik");
  GiveplayerMoney(playerid, 50000);
  SetPlayerControlable(playerid, true);
  return 1;
}

CMD:perbaikilistrik(playerid) {
  for(new i = 0; i < 5; i++) {
    if(IsPlayerInRangeOf(playerid, 3.0, X[i], Y[i], Z[i])) {
      SendClientMessage(playerid, -1, "Sedang memperbaiki listrik");
      SetPlayerControlable(playerid, false);
      SetTimerEx(playerid, "OnPerbaikiListrik", 20000);
      return 1;
    }
    else {
      SendClientMessage(playerid, -1, "Kamu tidak berada di tempat perbaikan
      listrik anapun!");
    }
  }
  return 1;
}