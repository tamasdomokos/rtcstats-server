CREATE TABLE features_import (
    browseruseragent character varying(1023),
    browsername character varying(255),
    browsernameos character varying(255),
    browsernameversion character varying(255),
    browsernameversionos character varying(255),
    browseros character varying(255),
    browsertype character varying(255),
    browserversion character varying(255),
    bwegoogactualencbitratemean real,
    bwegoogactualencbitratemax real,
    bwegoogactualencbitratemin real,
    bwegoogactualencbitratevariance real,
    bwegoogactualencbitrateskewness real,
    bwegoogactualencbitratekurtosis real,
    bwegoogretransmitbitratemean real,
    bwegoogretransmitbitratemax real,
    bwegoogretransmitbitratemin real,
    bwegoogretransmitbitratevariance real,
    bwegoogretransmitbitrateskewness real,
    bwegoogretransmitbitratekurtosis real,
    bwegoogtargetencbitratemean real,
    bwegoogtargetencbitratemax real,
    bwegoogtargetencbitratemin real,
    bwegoogtargetencbitratevariance real,
    bwegoogtargetencbitrateskewness real,
    bwegoogtargetencbitratekurtosis real,
    bwegoogbucketdelaymean real,
    bwegoogbucketdelaymax real,
    bwegoogbucketdelaymin real,
    bwegoogbucketdelayvariance real,
    bwegoogbucketdelayskewness real,
    bwegoogbucketdelaykurtosis real,
    bwegoogtransmitbitratemean real,
    bwegoogtransmitbitratemax real,
    bwegoogtransmitbitratemin real,
    bwegoogtransmitbitratevariance real,
    bwegoogtransmitbitrateskewness real,
    bwegoogtransmitbitratekurtosis real,
    bweavailableoutgoingbitratemean real,
    bweavailableoutgoingbitratemax real,
    bweavailableoutgoingbitratemin real,
    bweavailableoutgoingbitratevariance real,
    bweavailableoutgoingbitrateskewness real,
    bweavailableoutgoingbitratekurtosis real,
    bweavailableincomingbitratemean real,
    bweavailableincomingbitratemax real,
    bweavailableincomingbitratemin real,
    bweavailableincomingbitratevariance real,
    bweavailableincomingbitrateskewness real,
    bweavailableincomingbitratekurtosis real,
    calledgetusermedia boolean,
    calledgetusermediarequestingaudio boolean,
    calledgetusermediarequestingscreen character varying(255),
    calledgetusermediarequestingvideo boolean,
    calledlegacygetusermedia boolean,
    calledmediadevicesgetusermedia boolean,
    clientid character varying(255),
    clientidentifier character varying(255),
    conferenceidentifier character varying(4096),
    configured boolean,
    configuredbundlepolicy boolean,
    configuredcertificate boolean,
    configuredicetransportpolicy boolean,
    configuredrtcpmuxpolicy boolean,
    configuredwithiceservers boolean,
    configuredwithstun boolean,
    configuredwithturn boolean,
    configuredwithturntcp boolean,
    configuredwithturntls boolean,
    configuredwithturnudp boolean,
    connectionid character varying(255) default ''::character varying not null,
    connectiontime integer,
    date bigint,
    datetime bigint,
    dtlsciphersuite character varying(255),
    firstaudiotracklabel character varying(255),
    firstcandidatepairtype character varying(255),
    firstcandidatepairlocaltype character varying(255),
    firstcandidatepairremotetype character varying(255),
    firstcandidatepairlocalipaddress character varying(255),
    firstcandidatepairremoteipaddress character varying(255),
    firstcandidatepairlocaltypepreference integer,
    firstcandidatepairremotetypepreference integer,
    firstvideotracklabel character varying(255),
    gatheredhost boolean,
    gatheredstun boolean,
    gatheredturntcp boolean,
    gatheredturntls boolean,
    gatheredturnudp boolean,
    gatheredrfc1918addressprefix16 boolean,
    gatheredrfc1918addressprefix12 boolean,
    gatheredrfc1918addressprefix10 boolean,
    gatheringtime integer,
    gatheringtimeturntcp integer,
    gatheringtimeturntls integer,
    gatheringtimeturnudp integer,
    getusermediaerror character varying(255),
    getusermediasuccess boolean,
    hadremoteturncandidate boolean,
    iceconnectedorcompleted boolean,
    icefailure boolean,
    icefailuresubsequent boolean,
    icegatheringcomplete boolean,
    icerestart boolean,
    isinitiator boolean,
    localcreatedelay integer,
    maxstreams integer,
    mediatypes character varying(255),
    numberofcandidatepairchanges integer,
    numberoflocalicecandidates integer,
    numberofremoteicecandidates integer,
    numberofpeerconnections integer,
    pageurl character varying(4096),
    origin character varying(255),
    peeridentifier character varying(255),
    recvaudiocodec character varying(255),
    recvvideocodec character varying(255),
    remotetype character varying(255),
    sendaudiocodec character varying(255),
    sendvideocodec character varying(255),
    sessionduration integer,
    signalingstableatleastonce boolean,
    srtpciphersuite character varying(255),
    statsmeanaudiolevel real,
    statsmeanreceivingbitrate integer,
    statsmeanroundtriptime integer,
    statsmeansendingbitrate integer,
    timebetweengetusermediaandgetusermediasuccess integer,
    timebetweengetusermediaandgetusermediafailure integer,
    timebetweensetlocaldescriptionandonicecandidate integer,
    timebetweensetremotedescriptionandaddicecandidate integer,
    usingbundle boolean,
    usingicelite boolean,
    usingmultistream boolean,
    usingrtcpmux boolean,
    wasgoogbandwidthlimitedresolutionevertrue boolean,
    wasgoogcpulimitedresolutionevertrue boolean,
    audiosendaudiolevelmean real,
    audiosendaudiolevelmax real,
    audiosendaudiolevelmin real,
    audiosendaudiolevelvariance real,
    audiosendaudiolevelskewness real,
    audiosendaudiolevelkurtosis real,
    audiosendgoogjitterreceivedmean real,
    audiosendgoogjitterreceivedmax real,
    audiosendgoogjitterreceivedmin real,
    audiosendgoogjitterreceivedvariance real,
    audiosendgoogjitterreceivedskewness real,
    audiosendgoogjitterreceivedkurtosis real,
    audiosendgoogrttmean real,
    audiosendgoogrttmax real,
    audiosendgoogrttmin real,
    audiosendgoogrttvariance real,
    audiosendgoogrttskewness real,
    audiosendgoogrttkurtosis real,
    audiorecvaudiolevelmean real,
    audiorecvaudiolevelmax real,
    audiorecvaudiolevelmin real,
    audiorecvaudiolevelvariance real,
    audiorecvaudiolevelskewness real,
    audiorecvaudiolevelkurtosis real,
    audiorecvgoogjitterreceivedmean real,
    audiorecvgoogjitterreceivedmax real,
    audiorecvgoogjitterreceivedmin real,
    audiorecvgoogjitterreceivedvariance real,
    audiorecvgoogjitterreceivedskewness real,
    audiorecvgoogjitterreceivedkurtosis real,
    audiorecvgoogcurrentdelaymsmean real,
    audiorecvgoogcurrentdelaymsmax real,
    audiorecvgoogcurrentdelaymsmin real,
    audiorecvgoogcurrentdelaymsvariance real,
    audiorecvgoogcurrentdelaymsskewness real,
    audiorecvgoogcurrentdelaymskurtosis real,
    audiorecvgoogjitterbuffermsmean real,
    audiorecvgoogjitterbuffermsmax real,
    audiorecvgoogjitterbuffermsmin real,
    audiorecvgoogjitterbuffermsvariance real,
    audiorecvgoogjitterbuffermsskewness real,
    audiorecvgoogjitterbuffermskurtosis real,
    audiorecvgoogpreferredjitterbuffermsmean real,
    audiorecvgoogpreferredjitterbuffermsmax real,
    audiorecvgoogpreferredjitterbuffermsmin real,
    audiorecvgoogpreferredjitterbuffermsvariance real,
    audiorecvgoogpreferredjitterbuffermsskewness real,
    audiorecvgoogpreferredjitterbuffermskurtosis real,
    videosendgoogrttmean real,
    videosendgoogrttmax real,
    videosendgoogrttmin real,
    videosendgoogrttvariance real,
    videosendgoogrttskewness real,
    videosendgoogrttkurtosis real,
    videosendgoogencodeusagepercentmean real,
    videosendgoogencodeusagepercentmax real,
    videosendgoogencodeusagepercentmin real,
    videosendgoogencodeusagepercentvariance real,
    videosendgoogencodeusagepercentskewness real,
    videosendgoogencodeusagepercentkurtosis real,
    videosendgoogframeheightinputmax real,
    videosendgoogframeheightinputmin real,
    videosendgoogframeheightinputmode real,
    videosendgoogframeheightsentmax real,
    videosendgoogframeheightsentmin real,
    videosendgoogframeheightsentmode real,
    videosendgoogframewidthinputmax real,
    videosendgoogframewidthinputmin real,
    videosendgoogframewidthinputmode real,
    videosendgoogframewidthsentmax real,
    videosendgoogframewidthsentmin real,
    videosendgoogframewidthsentmode real,
    videosendgoogcpulimitedresolutionmean real,
    videosendgoogcpulimitedresolutionmax real,
    videosendgoogcpulimitedresolutionmin real,
    videosendgoogcpulimitedresolutionmode real,
    videosendgoogbandwidthlimitedresolutionmean real,
    videosendgoogbandwidthlimitedresolutionmax real,
    videosendgoogbandwidthlimitedresolutionmin real,
    videosendgoogbandwidthlimitedresolutionmode real,
    videorecvgoogcurrentdelaymsmean real,
    videorecvgoogcurrentdelaymsmax real,
    videorecvgoogcurrentdelaymsmin real,
    videorecvgoogcurrentdelaymsvariance real,
    videorecvgoogcurrentdelaymsskewness real,
    videorecvgoogcurrentdelaymskurtosis real,
    videorecvgoogjitterbuffermsmean real,
    videorecvgoogjitterbuffermsmax real,
    videorecvgoogjitterbuffermsmin real,
    videorecvgoogjitterbuffermsvariance real,
    videorecvgoogjitterbuffermsskewness real,
    videorecvgoogjitterbuffermskurtosis real,
    videorecvgoogdecodemsmean real,
    videorecvgoogdecodemsmax real,
    videorecvgoogdecodemsmin real,
    videorecvgoogdecodemsvariance real,
    videorecvgoogdecodemsskewness real,
    videorecvgoogdecodemskurtosis real,
    videorecvgoogmaxdecodemsmean real,
    videorecvgoogmaxdecodemsmax real,
    videorecvgoogmaxdecodemsmin real,
    videorecvgoogmaxdecodemsvariance real,
    videorecvgoogmaxdecodemsskewness real,
    videorecvgoogmaxdecodemskurtosis real,
    videorecvgoogminplayoutdelaymsmean real,
    videorecvgoogminplayoutdelaymsmax real,
    videorecvgoogminplayoutdelaymsmin real,
    videorecvgoogminplayoutdelaymsvariance real,
    videorecvgoogminplayoutdelaymsskewness real,
    videorecvgoogminplayoutdelaymskurtosis real,
    videorecvgoogrenderdelaymsmean real,
    videorecvgoogrenderdelaymsmax real,
    videorecvgoogrenderdelaymsmin real,
    videorecvgoogrenderdelaymsvariance real,
    videorecvgoogrenderdelaymsskewness real,
    videorecvgoogrenderdelaymskurtosis real,
    videorecvgoogtargetdelaymsmean real,
    videorecvgoogtargetdelaymsmax real,
    videorecvgoogtargetdelaymsmin real,
    videorecvgoogtargetdelaymsvariance real,
    videorecvgoogtargetdelaymsskewness real,
    videorecvgoogtargetdelaymskurtosis real,
    videorecvgoogframeheightreceivedmax real,
    videorecvgoogframeheightreceivedmin real,
    videorecvgoogframeheightreceivedmode real,
    videorecvgoogframewidthreceivedmax real,
    videorecvgoogframewidthreceivedmin real,
    videorecvgoogframewidthreceivedmode real,
    relayaddress character varying(255),
    notsendingaudio boolean,
    notsendingvideo boolean,
    receivingvideo10spacketsreceived real,
    receivingvideo10sframewidth real,
    receivingvideo10sframeheight real,
    browsermajorversion integer,
    starttime bigint,
    icerestartsuccess boolean,
    icerestartfollowedbysetremotedescription boolean,
    numberofinterfaces integer,
    icerestartfollowedbyrelaycandidate boolean,
    setlocaldescriptionfailure character varying(255),
    setremotedescriptionfailure character varying(255),
    addicecandidatefailure character varying(255),
    stoptime bigint,
    lifetime integer,
    locationLon real,
    locationLat real,
    locationLonLat character varying(255),
    locationContinent character varying(16),
    locationCountry character varying(255),
    locationCity character varying(255),
    publicipaddress character varying(255),
    userfeedbackaudio integer,
    userfeedbackvideo integer,
    receivingaudio10spacketsreceived real,
    receivingaudio10sjitterbufferms real,
    timeuntilreceivingvideo bigint
);
