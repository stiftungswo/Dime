function getPikadayMillisecondsSinceEpoch(pikaday) {
    return pikaday.getDate().getTime();
}

function setPikadayMillisecondsSinceEpoch(pikaday, millies, triggerOnSelect) {
    pikaday.setDate(new Date(millies), triggerOnSelect);
}

function setPikadayMinDateAsMillisecondsSinceEpoch(pikaday, millies) {
    pikaday.setMinDate(new Date(millies));
}

function setPikadayMaxDateAsMillisecondsSinceEpoch(pikaday, millies) {
    pikaday.setMaxDate(new Date(millies));
}
