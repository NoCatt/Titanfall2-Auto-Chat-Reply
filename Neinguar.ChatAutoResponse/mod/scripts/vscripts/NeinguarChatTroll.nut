global function NeinguarChatTroll_Init

string TriggerWords =GetConVarString("words")
string TriggerResponse = GetConVarString("response")
string
array<string> TriggerWordsArray = split(Triggerwords,",")
array<string> TriggerRepsonseArray = split(TriggerResponse,",")
array<string> BannedWords = split(GetConVar("BannedWords"),",")

string TrollMessage = GetConVarString("RandomTrollMessage")
int ChanceOfTrollMessage = GetConVarInt(ChanceOfTrollMessage)


void function NeinguarChatTroll_Init() {
    AddCallback_OnReceivedSayTextMessage(MyChatFilter)
}

ClClient_MessageStruct function MyChatFilter(ClClient_MessageStruct message) {
    try{
   foreach(index, word in TriggerWordsArray){
    if(message.message.find(word)!=null||message.message.find(word.toupper())!=null||message.message.find(word.tolower())!=null)
        Chat_ServerBroadcast(TriggerResponseArray[index])
    }
    if(RandomInt(ChanceOfTrollMessage)==1){
        Chat_Impersonate( message.player, "I am very bad at this game :(" , false)
        return message
    }
    for(badWord in BannedWords){
        if(message.message.find(badWord)!= null){
            message.shouldBlock = true
            Chat_privateMessage(message.player, "You used a bad word no message has been send", false)
        }
    }
    return message
    }catch(ex){}
}