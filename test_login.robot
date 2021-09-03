*** Settings ***
Library           Selenium2Library
Library           getcodeLibrary
Library           checkcodeLibrary
Library           keyboard
Metadata    author     L
Metadata    version    1.0

*** Test Cases ***
case01 [Documentation] 登录智慧网格系统
#    baidu_search
#    Login-checkCode
    Login-getCode

*** Keywords ***

Login-getCode
    open browser    http://sqwytst.wt.com:14352/   chrome
    maximize_browser_window
    wait until element is enabled    xpath://*[@id="app"]/div/div[1]/div/span
    Click Element    xpath://*[@id="app"]/div/div[1]/div/span
    sleep    2
    FOR   ${index}  IN RANGE  10
        input text    name=username    13734206025
        input text    name=password    asdqwe123
         #    设置截图路径
        set screenshot directory        ${CURDIR}/picture
         #    截图并保存
        capture_page_screenshot         ${CURDIR}/picture/1.png
        ${code}    getCode     ${CURDIR}\\picture\\
        input text    name=imgCode    ${code}
        click button    id=login
        sleep   2
        ${currentUrl}       get locations
        log   ${currentUrl}
        # 判断地址为error 则继续循环，地址为其他，退出循环
        ${result}       ${resultvalue}     run keyword and ignore error     set variable if    '${currentUrl}[0]'=='http://sso.wt.com:3100/loginPage?error'    登录失败    ${currentUrl}   登录成功
        Exit For Loop If   '${resultvalue}'=='登录成功'
    END
    sleep   5
    click Element    xpath://*[@id="app"]/div/div[2]/div/div/div[2]/div[2]/div[3]/table/tbody/tr/td[2]/div
    click Element    xpath:/html/body/div[1]/div/div[2]/div/div/div[3]/div/button[2]/span
    sleep   5
    click Element    xpath://*[@id="app"]/div/div[1]/div/div[1]/div/ul/div[3]/a/li/div
    input text      xpath://*[@id="appMain"]/div/div[1]/div/main/div/div[1]/div/form/div[1]/div/div/input     大同招生政府
    click element   xpath://*[@id="appMain"]/div/div[1]/div/main/div/div[1]/div/form/div[6]/div/button[1]/span
    page_should_contain    大同招生政府
    click Element    xpath://*[@id="app"]/div/div[1]/div/div[1]/div/ul/div[2]/span/span/li/div
    sleep   2
    drag_and_drop_by_offset    xpath://*[@id="app"]/div/div[1]/div/div[1]/div/ul/div[2]/span/span/li/i    0    20
#    click element   xpath://*[@id="el-popover-534"]/a/li/div
    page_should_contain    当前位置：平城区
    close browser
#    Should Contain    name=wd    robotframework


baidu_search
    open browser    http://www.baidu.com    chrome
    maximize_browser_window
    input text    id:kw    robotframework
    click button    id:su
    sleep    5
    set screenshot directory        ${CURDIR}/picture
    capture_page_screenshot         ${CURDIR}/picture/1.png
    ${code}    getCode     ${CURDIR}\\picture\\
    log     ${code}
    open context menu   //*[@id="2"]/div/div[1]/a/span
    send    down
    send    down
    send    down
    send    down
    send    enter
#    send    ${CURDIR}/picture
    sleep    3
    send    enter
#    close browser


Login-checkCode
    open browser    http://sqwytst.wt.com:14352/   chrome
    maximize_browser_window
    wait until element is enabled    xpath://*[@id="app"]/div/div[1]/div/span
    Click Element    xpath://*[@id="app"]/div/div[1]/div/span
    sleep    2
    input text    name=username    18730001028
    input text    name=password    123456
    open context menu    xpath://*[@id="codeImage"]
    send    down
    send    down
    send    enter
    sleep    3
    send    enter
    sleep    3
    ${code}    checkCode     ${CURDIR}\\picture\\
    input text    name=imgCode    ${code}
    click button    id=login
#    close browser
#    Should Contain    name=wd    robotframework



userApply
    click button    //*[@id="app"]/div/div[1]/div/div[1]/div/ul/div[3]/a/li/div
    input text    //*[@id="appMain"]/div/div[1]/div/main/div/div[1]/div/form/div[1]/div/div/input    张辉
    click button    //*[@id="appMain"]/div/div[1]/div/main/div/div[1]/div/form/div[6]/div/button[1]/span
    page should contain    张辉
*** Comments ***
注释