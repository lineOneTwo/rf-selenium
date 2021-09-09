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
        ${title}       get window titles
        # 判断地址为error，则为登录失败，退出条件为登录成功，不符合条件继续循环，地址为其他，则为登录成功，符合退出条件
        ${result}       ${resultvalue}     run keyword and ignore error     set variable if    '${currentUrl}[0]'=='http://sso.wt.com:3100/loginPage?error'    登录失败    ${currentUrl}   登录成功
        Exit For Loop If   '${resultvalue}'=='登录成功'
    END
    sleep   5
    click Element    xpath://*[@id="app"]/div/div[2]/div/div/div[2]/div[2]/div[3]/table/tbody/tr/td[2]/div
    click Element    xpath:/html/body/div[1]/div/div[2]/div/div/div[3]/div/button[2]/span
    sleep   5
    # 申请管理
    # 输入申请人
    click Element    xpath://*[@id="app"]/div/div[1]/div/div[1]/div/ul/div[3]/a/li/div
    input text       xpath://*[@id="appMain"]/div/div[1]/div/main/div/div[1]/div/form/div[1]/div/div/input     大同招生政府
    # 选择机构名称
    click element    xpath://*[@id="appMain"]/div/div[1]/div/main/div/div[1]/div/form/div[4]/div/div/div/input  # 点击下拉框
    sleep   3
    click element    xpath:/html/body/div[2]/div/div[1]/div/ul/li/span  # 点击平城区
    sleep   3
    click element    xpath:/html/body/div[2]/div/div[2]/div/ul/li[1]/span   # 点击街道
    sleep   3
    click element    xpath:/html/body/div[2]/div/div[3]/div/ul/li[1]/span   # 点击社区
    sleep   3
    click element    xpath:/html/body/div[2]/div/div[4]/div/ul/li[1]/label/span[1]/span   #选择网格
    sleep   3
    # 选择审核状态
    click element    xpath://*[@id="appMain"]/div/div[1]/div/main/div/div[1]/div/form/div[3]/div/div/div/input
    sleep   3
    click element    xpath:/html/body/div[3]/div[1]/div[1]/ul/li[2]
    # 选择是否兼职
    click element    xpath://*[@id="appMain"]/div/div[1]/div/main/div/div[1]/div/form/div[5]/div/div/div/input
    sleep   3
    click element    xpath:/html/body/div[4]/div[1]/div[1]/ul/li[2]/span
    # 点击查询按钮并检查返回值
    click element    xpath://*[@id="appMain"]/div/div[1]/div/main/div/div[1]/div/form/div[6]/div/button[1]/span     # 点击查询按钮
    Run Keyword And Continue On Failure    page_should_contain    大同招生政府
    # 网格管理模块
    click Element    xpath://*[@id="app"]/div/div[1]/div/div[1]/div/ul/div[2]/span/span/li/div
    sleep   5
    click Element    xpath:/html/body/div[5]/a/li/div
    Run Keyword And Continue On Failure    page_should_contain    当前位置：平城区
    # 通知公告
    click element    xpath://*[@id="app"]/div/div[1]/div/div[1]/div/ul/div[4]/a/li/div
    sleep   5
    # 查询
    input text       xpath://*[@id="appMain"]/div/div[1]/div[2]/div/form/div[1]/div/div/input     测试
    click element    xpath://*[@id="appMain"]/div/div[1]/div[2]/div/form/div[2]/div/button[1]/span
    # 添加
    click element    xpath://*[@id="appMain"]/div/div[1]/div[1]/button/span
    sleep   5
    input text       xpath://*[@id="appMain"]/div/div[2]/div/div/div[2]/form/div[1]/div/div[1]/input    测试
    input text       xpath:/html/body/div[1]/div/div[2]/section/div/div[2]/div/div/div[2]/form/div[2]/div/div/div/div/div[2]/iframe            测试
    click element    xpath://*[@id="appMain"]/div/div[2]/div/div/div[3]/div/button[2]
    #
#    close browser
#    Should Contain    name=wd    robotframework