#include <a_samp>
#include <zcmd>
#include <sscanf2>

#define MAX_LOKASI 5
#define DIALOG_PLN 1000
#define PADAM_TIMER 180000
#define REPAIR_TIME 20000
#define SKIN_PLN 260

new Float:LokasiX[MAX_LOKASI] = {
  1446.46,
  1044.85,
  -118.76,
  672.04,
  218.27
};

new Float:LokasiY[MAX_LOKASI] = {
  -934.31,
  -1362.66,
  -1239.36,
  -590.57,
  -291.49
};

new Float:LokasiZ[MAX_LOKASI] = {
  36.35,
  13.57,
  2.78,
  16.33,
  1.57
};

new bool:ListrikPadam[MAX_LOKASI];
new duty[MAX_PLAYERS];
new repairing[MAX_PLAYERS];
new repairLokasi[MAX_PLAYERS];

forward RandomPadam();
forward FinishRepair(playerid, lokasi);

public OnFilterScriptInit() {
  print("Job PLN berhasil dimuat.");
  SetTimer("RandomPadam", PADAM_TIMER, true);
  
  for(new i; i < MAX_LOKASI; i++) {
    ListrikPadam[i] = false;
  }
  return 1;
}

public OnPlayerDisconnect(playerid, reason) {
  duty[playerid] = 0;
  repairing[playerid] = 0;
  repairLokasi[playerid] = -1;
  return 1;
}

CMD:dutypln(playerid) {
  if(duty[playerid] == 0) {
    duty[playerid] = 1;
    SetPlayerSkin(playerid, SKIN_PLN);
    SendClientMessage(playerid, -1, "[PLN] Kamu sekarang duty teknisi listrik.");
  }
  else {
    duty[playerid] = 0;
    SendClientMessage(playerid, -1, "[PLN] Kamu sekarang off duty.");
  }
  return 1;
}

CMD:listlistrik(playerid) {
  if(!duty[playerid]) {
    SendClientMessage(playerid, -1, "[PLN] Kamu tidak sedang duty.");
    return 1;
  }

  new dialog[512];
  new line[64];

  dialog = "";

  for(new i; i < MAX_LOKASI; i++) {
    if(ListrikPadam[i]) {
      format(line, sizeof(line), "Lokasi %d (PADAM)\n", i+1);
    }
    else {
      format(line, sizeof(line), "Lokasi %d (Normal)\n", i+1);
    }
    strcat(dialog, line);
  }

  ShowPlayerDialog(playerid, DIALOG_PLN, DIALOG_STYLE_LIST, "Status Listrik Kota", dialog, "Check", "Tutup");
  return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
  if(dialogid == DIALOG_PLN) {
    if(!response) return 1;

    if(!ListrikPadam[listitem]) {
      SendClientMessage(playerid, -1, "[PLN] Lokasi ini tidak mengalami pemadaman.");
      return 1;
    }

    SetPlayerCheckpoint(playerid, LokasiX[listitem], LokasiY[listitem], LokasiZ[listitem], 3.0);
    repairLokasi[playerid] = listitem;
    SendClientMessage(playerid, -1, "[PLN] Checkpoint telah ditandai.");
  }
  return 1;
}

CMD:perbaikilistrik(playerid) {
  if(!duty[playerid]) {
    SendClientMessage(playerid, -1, "[PLN] Kamu tidak duty.");
    return 1;
  }

  if(repairing[playerid]) {
    SendClientMessage(playerid, -1, "[PLN] Kamu sedang memperbaiki listrik.");
    return 1;
  }

  new i = repairLokasi[playerid];

  if(i < 0 || i >= MAX_LOKASI) {
    SendClientMessage(playerid, -1, "[PLN] Kamu belum memilih lokasi.");
    return 1;
  }

  if(!IsPlayerInRangeOfPoint(playerid, 3.0, LokasiX[i], LokasiY[i], LokasiZ[i])) {
    SendClientMessage(playerid, -1, "[PLN] Kamu tidak berada di lokasi listrik.");
    return 1;
  }

  if(!ListrikPadam[i]) {
    SendClientMessage(playerid, -1, "[PLN] Listrik di sini sudah normal.");
    return 1;
  }

  repairing[playerid] = 1;

  SendClientMessage(playerid, -1, "[PLN] Memperbaiki listrik...");

  TogglePlayerControllable(playerid, false);

  ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 1, 0, 0, 1, 0);

  SetTimerEx("FinishRepair", REPAIR_TIME, false, "dd", playerid, i);

  return 1;
}

public FinishRepair(playerid, lokasi) {
  if(!IsPlayerConnected(playerid)) return 1;

  repairing[playerid] = 0;
  ListrikPadam[lokasi] = false;

  DisablePlayerCheckpoint(playerid);

  ClearAnimations(playerid);

  TogglePlayerControllable(playerid, true);

  GivePlayerMoney(playerid, 50000);

  SendClientMessage(playerid, -1, "[PLN] Listrik berhasil diperbaiki! +$50.000");

  return 1;
}

public RandomPadam() {
  new lokasi = random(MAX_LOKASI);

  if(!ListrikPadam[lokasi]) {
    ListrikPadam[lokasi] = true;

    new msg[128];

    format(msg, sizeof(msg), "[PLN] Pemadaman listrik terjadi di lokasi %d!", lokasi+1);

    SendClientMessageToAll(-1, msg);
  }

  return 1;
}
