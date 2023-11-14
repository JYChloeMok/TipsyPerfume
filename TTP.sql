DROP TABLE "TB_REVIEW_LIKE";
DROP TABLE "TB_BOARD_LIKE";
DROP TABLE "TB_AUTH";
DROP TABLE "TB_NOTICE";
/*DROP TABLE "TB_ORDER_UNLOGIN";*/
DROP TABLE "TB_ORDER_COMPLAIN";
DROP TABLE "TB_COMMENT";
DROP TABLE "TB_BOARD_FILE";
DROP TABLE "TB_BOARD";
DROP TABLE "TB_BOARD_CTGY";
DROP TABLE "TB_REVIEW_FILE";
DROP TABLE "TB_REVIEW";
DROP TABLE "TB_FUNDING";
DROP TABLE "TB_PRODUCT_FILE";
DROP TABLE "TB_ORDER_DETAIL";
DROP TABLE "TB_PAYMENT";
DROP TABLE "TB_PRODUCT_OPTION";
DROP TABLE "TB_ORDER";
DROP TABLE "TB_WISHLIST";
DROP TABLE "TB_CART";
DROP TABLE "TB_RECEIVER";
DROP TABLE "TB_PRODUCT";
DROP TABLE "TB_PRODUCT_CATEGORY";
DROP TABLE "TB_USER";

CREATE TABLE "TB_PRODUCT" (
	"PDT_NO"	NUMBER		NOT NULL,
	"PDT_CATEG_NO"	NUMBER		NOT NULL,
	"PDT_NAME"	VARCHAR2(500)		NULL,
	"PDT_PRICE"	NUMBER		NULL,
	"PDT_STOCK"	NUMBER		NULL,
	"PDT_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"PDT_INTRO"	VARCHAR2(2000)		NULL,
	"PDT_DESCRIPTION"	VARCHAR2(2000)		NULL,
	"PDT_INGREDIENT"	VARCHAR2(2000)		NULL,
	"PDT_SHIPPING"	VARCHAR2(1000)		NULL,
	"PDT_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"PDT_DISCOUNT"	NUMBER	DEFAULT 2	NULL,
	"PDT_STATUS"	VARCHAR2(1)		NULL,
	"PDT_GP_STATUS"	VARCHAR2(1)	DEFAULT 'N'	NULL
);

COMMENT ON COLUMN "TB_PRODUCT"."PDT_NO" IS '상품 번호';

COMMENT ON COLUMN "TB_PRODUCT"."PDT_CATEG_NO" IS '상품 카테고리(옵션, 분류) 번호';

COMMENT ON COLUMN "TB_PRODUCT"."PDT_DATE" IS '상품 등록일';

COMMENT ON COLUMN "TB_PRODUCT"."PDT_INTRO" IS '상품 기본 소개';

COMMENT ON COLUMN "TB_PRODUCT"."PDT_DESCRIPTION" IS '상품 상세 설명';

COMMENT ON COLUMN "TB_PRODUCT"."PDT_INGREDIENT" IS '상품 원료(재료, 성분)';

COMMENT ON COLUMN "TB_PRODUCT"."PDT_SHIPPING" IS '배송방법, 배송비, 무료배송 기준 등 안내';

COMMENT ON COLUMN "TB_PRODUCT"."PDT_COUNT" IS '상품 게시글 조회수';

COMMENT ON COLUMN "TB_PRODUCT"."PDT_DISCOUNT" IS '할인률';

COMMENT ON COLUMN "TB_PRODUCT"."PDT_STATUS" IS '판매 노출 여부 / Y : 판매중, N : 판매중이 아님';

COMMENT ON COLUMN "TB_PRODUCT"."PDT_GP_STATUS" IS '공구 가능 여부(역정규) / Y=공구+일반판매, N=일반판매';


CREATE TABLE "TB_CART" (
	"CART_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
	"PDT_NO"	NUMBER		NOT NULL,
	"CART_QUANTIRY"	NUMBER	DEFAULT 1	NOT NULL
);

COMMENT ON COLUMN "TB_CART"."USER_NO" IS '회원 번호';

COMMENT ON COLUMN "TB_CART"."PDT_NO" IS '상품 번호';

COMMENT ON COLUMN "TB_CART"."CART_QUANTIRY" IS '상품 수량';



CREATE TABLE "TB_USER" (
	"USER_NO"	NUMBER		NOT NULL,
	"USER_EMAIL"	VARCHAR2(50)		NOT NULL,
	"NICKNAME"	VARCHAR2(20)		NOT NULL,
	"USER_PWD"	VARCHAR2(60)		NOT NULL,
	"USER_NAME"	VARCHAR2(20)		NOT NULL,
	"STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NULL,
	"MEMBER_TYPE"	VARCHAR2(1)	DEFAULT 'U'	NOT NULL,
	"BUSINESS_REG"	VARCHAR(1)	DEFAULT 'N'	NULL,
	"ADULT_STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NULL,
	"BIRTH_DATE"	DATE		NOT NULL,
	"ENROLL_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"USER_PROFILE"	VARCHAR2(100)	DEFAULT null	NULL
);

COMMENT ON COLUMN "TB_USER"."USER_NO" IS '회원 번호';

COMMENT ON COLUMN "TB_USER"."USER_EMAIL" IS '가입 시 적은 회원 이메일';

COMMENT ON COLUMN "TB_USER"."NICKNAME" IS '20글자이내.비속어X';

COMMENT ON COLUMN "TB_USER"."USER_PWD" IS '!@#$%^&*특수기호1개이상?';

COMMENT ON COLUMN "TB_USER"."STATUS" IS 'N: 탈퇴 Y :활동 X:미승인 B:알람띄워주는거(1회)';

COMMENT ON COLUMN "TB_USER"."MEMBER_TYPE" IS 'S: 판매자 U:이용자 A: 관리자';

COMMENT ON COLUMN "TB_USER"."BUSINESS_REG" IS '기본N , 등록했을경우 Y';

COMMENT ON COLUMN "TB_USER"."ADULT_STATUS" IS '성인인증 여부';

COMMENT ON COLUMN "TB_USER"."BIRTH_DATE" IS 'YYYY-MM-DD';

COMMENT ON COLUMN "TB_USER"."ENROLL_DATE" IS 'YYYY-MM-DD';


CREATE TABLE "TB_WISHLIST" (
	"PDT_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
	"WISHLIST_DATE"	DATE	DEFAULT SYSDATE	NULL
);

COMMENT ON COLUMN "TB_WISHLIST"."PDT_NO" IS '상품 번호';

COMMENT ON COLUMN "TB_WISHLIST"."USER_NO" IS '회원 번호';

COMMENT ON COLUMN "TB_WISHLIST"."WISHLIST_DATE" IS '위시리스트 추가날짜';


CREATE TABLE "TB_REVIEW" (
	"REVIEW_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
	"REVIEW_SCORE"	NUMBER	DEFAULT 0	NULL,
	"REVIEW_CONTENT"	VARCHAR2(2000)		NOT NULL,
	"REVIEW_CREATE_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"REVIEW_MODIFY_DATE"	DATE		NULL,
	"REVIEW_STATE"	CHAR(1)	DEFAULT 'Y' CHECK(REVIEW_STATE IN ('Y','N'))	NULL,
	"PDT_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "TB_REVIEW"."REVIEW_NO" IS '리뷰 번호';

COMMENT ON COLUMN "TB_REVIEW"."USER_NO" IS '작성자 번호';

COMMENT ON COLUMN "TB_REVIEW"."REVIEW_SCORE" IS '점수';

COMMENT ON COLUMN "TB_REVIEW"."REVIEW_CONTENT" IS '내용';

COMMENT ON COLUMN "TB_REVIEW"."REVIEW_CREATE_DATE" IS '작성일';

COMMENT ON COLUMN "TB_REVIEW"."REVIEW_MODIFY_DATE" IS '수정일';

COMMENT ON COLUMN "TB_REVIEW"."REVIEW_STATE" IS '활성여부';

COMMENT ON COLUMN "TB_REVIEW"."PDT_NO" IS '상품 번호';


CREATE TABLE "TB_BOARD" (
	"BOARD_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
	"BOARD_TITLE"	VARCHAR2(2000)		NOT NULL,
	"BOARD_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"BOARD_CREATE_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"BOARD_MODIFY_DATE"	DATE		NULL,
	"BOARD_CTGY_CODE"	VARCHAR2(5)		NOT NULL,
	"BOARD_STATE"	CHAR(1)	DEFAULT 'Y' CHECK(BOARD_STATE IN ('Y','N'))	NULL,
	"BOARD_COUNT"	NUMBER	DEFAULT 0	NULL
);

COMMENT ON COLUMN "TB_BOARD"."BOARD_NO" IS '게시판 번호';

COMMENT ON COLUMN "TB_BOARD"."USER_NO" IS '작성자 번호';

COMMENT ON COLUMN "TB_BOARD"."BOARD_TITLE" IS '게시판 제목';

COMMENT ON COLUMN "TB_BOARD"."BOARD_CONTENT" IS '게시판 내용';

COMMENT ON COLUMN "TB_BOARD"."BOARD_CREATE_DATE" IS '작성일';

COMMENT ON COLUMN "TB_BOARD"."BOARD_MODIFY_DATE" IS '수정일';

COMMENT ON COLUMN "TB_BOARD"."BOARD_CTGY_CODE" IS '카테고리 코드';

COMMENT ON COLUMN "TB_BOARD"."BOARD_STATE" IS '활성여부';

COMMENT ON COLUMN "TB_BOARD"."BOARD_COUNT" IS '조회수';


CREATE TABLE "TB_COMMENT" (
	"COMMENT_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL,
	"REVIEW_NO"	NUMBER		NOT NULL,
	"COMMENT_CONTENT"	VARCHAR2(2000)		NOT NULL,
	"COMMENT_CREATE_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"COMMENT_MODIFY_DATE"	DATE		NULL,
	"COMMENT_GROUP"	NUMBER		NOT NULL,
	"COMMENT_INDEX"	NUMBER	DEFAULT 0	NULL,
	"COMMENT_DEPTH"	NUMBER	DEFAULT 0	NULL,
	"COMMENT_STATE"	CHAR(1)	DEFAULT 'Y' CHECK(COMMENT_STATE IN ('Y','N'))	NULL
);

COMMENT ON COLUMN "TB_COMMENT"."COMMENT_NO" IS '댓글 번호';

COMMENT ON COLUMN "TB_COMMENT"."USER_NO" IS '작성자 번호';

COMMENT ON COLUMN "TB_COMMENT"."BOARD_NO" IS '게시판 번호';

COMMENT ON COLUMN "TB_COMMENT"."REVIEW_NO" IS '리뷰 번호';

COMMENT ON COLUMN "TB_COMMENT"."COMMENT_CONTENT" IS '댓글 내용';

COMMENT ON COLUMN "TB_COMMENT"."COMMENT_CREATE_DATE" IS '작성일';

COMMENT ON COLUMN "TB_COMMENT"."COMMENT_MODIFY_DATE" IS '수정일';

COMMENT ON COLUMN "TB_COMMENT"."COMMENT_GROUP" IS '댓글 그룹';

COMMENT ON COLUMN "TB_COMMENT"."COMMENT_INDEX" IS '댓글 인덱스';

COMMENT ON COLUMN "TB_COMMENT"."COMMENT_DEPTH" IS '댓글 깊이';

COMMENT ON COLUMN "TB_COMMENT"."COMMENT_STATE" IS '활성여부';


CREATE TABLE "TB_REVIEW_FILE" (
	"REVIEW_FILE_NO"	NUMBER		NOT NULL,
	"REVIEW_FILE_ORIGIN"	VARCHAR2(100)		NOT NULL,
	"REVIEW_FILE_UPLOAD"	VARCHAR2(100)		NOT NULL,
	"REVIEW_FILE_PATH"	VARCHAR2(100)		NOT NULL,
	"REVIEW_FILE_INDEX"	NUMBER	DEFAULT 0	NULL,
	"REVIEW_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "TB_REVIEW_FILE"."REVIEW_FILE_NO" IS '파일 번호';

COMMENT ON COLUMN "TB_REVIEW_FILE"."REVIEW_FILE_ORIGIN" IS '원본 이름';

COMMENT ON COLUMN "TB_REVIEW_FILE"."REVIEW_FILE_UPLOAD" IS '업로드 이름';

COMMENT ON COLUMN "TB_REVIEW_FILE"."REVIEW_FILE_PATH" IS '파일 경로';

COMMENT ON COLUMN "TB_REVIEW_FILE"."REVIEW_FILE_INDEX" IS '파일 인덱스';

COMMENT ON COLUMN "TB_REVIEW_FILE"."REVIEW_NO" IS '리뷰 번호';


CREATE TABLE "TB_BOARD_FILE" (
	"BOARD_FILE_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL,
	"BOARD_FILE_ORIGIN"	VARCHAR2(100)		NOT NULL,
	"BOARD_FILE_UPLOAD"	VARCHAR2(100)		NOT NULL,
	"BOARD_FILE_PATH"	VARCHAR2(100)		NOT NULL,
	"BOARD_FILE_INDEX"	NUMBER	DEFAULT 0	NULL
);

COMMENT ON COLUMN "TB_BOARD_FILE"."BOARD_FILE_NO" IS '파일 번호';

COMMENT ON COLUMN "TB_BOARD_FILE"."BOARD_NO" IS '게시판 번호';

COMMENT ON COLUMN "TB_BOARD_FILE"."BOARD_FILE_ORIGIN" IS '원본 이름';

COMMENT ON COLUMN "TB_BOARD_FILE"."BOARD_FILE_UPLOAD" IS '업로드 이름';

COMMENT ON COLUMN "TB_BOARD_FILE"."BOARD_FILE_PATH" IS '파일 경로';

COMMENT ON COLUMN "TB_BOARD_FILE"."BOARD_FILE_INDEX" IS '파일 인덱스';


CREATE TABLE "TB_BOARD_CTGY" (
	"BOARD_CTGY_CODE"	VARCHAR2(5)		NOT NULL,
	"BOARD_CTGY_NAME"	VARCHAR2(100)		NOT NULL
);

COMMENT ON COLUMN "TB_BOARD_CTGY"."BOARD_CTGY_CODE" IS '카테고리 코드';

COMMENT ON COLUMN "TB_BOARD_CTGY"."BOARD_CTGY_NAME" IS '카테고리 이름';


CREATE TABLE "TB_FUNDING" (
	"FUNDING_NO"	NUMBER		NOT NULL,
	"PDT_NO"	NUMBER		NOT NULL,
	"FUNDING_VIEW_COUNT"	NUMBER		NULL,
	"CUTTING_DATE"	DATE		NOT NULL,
	"FUNDING_FEE"	NUMBER		NULL,
	"CUTTING_PRICE"	NUMBER		NOT NULL
);


CREATE TABLE "TB_ORDER" (
	"ORDER_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
	"RECEIVER_NO"	NUMBER		NOT NULL,
	"ORDER_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"ORDER_EST_DATE"	DATE		NULL,
	"ORDER_ARRIV_DATE"	DATE		NULL,
	"ORDER_MESSAGE"	VARCHAR2(90)		NULL
);

COMMENT ON COLUMN "TB_ORDER"."ORDER_NO" IS '주문 번호';

COMMENT ON COLUMN "TB_ORDER"."USER_NO" IS '주문한 회원번호';

COMMENT ON COLUMN "TB_ORDER"."RECEIVER_NO" IS '배송정보 주소';

COMMENT ON COLUMN "TB_ORDER"."ORDER_DATE" IS '주문일 YYYY-MM-DD';

COMMENT ON COLUMN "TB_ORDER"."ORDER_EST_DATE" IS '도착예상일 YYYY-MM-DD';

COMMENT ON COLUMN "TB_ORDER"."ORDER_ARRIV_DATE" IS '배송완료일YYYY-MM-DD';

COMMENT ON COLUMN "TB_ORDER"."ORDER_MESSAGE" IS '배송 요청사항';


CREATE TABLE "TB_PRODUCT_CATEGORY" (
	"PDT_CATEG_NO"	NUMBER		NOT NULL,
	"PDT_CTEG"	VARCHAR2(1)		NOT NULL,
	"PDT_FAMILY"	VARCHAR2(1)		NOT NULL,
	"PDT_MANUFAC"	VARCHAR2(100)		NOT NULL,
	"PDT_GROUP"	VARCHAR2(100)		NULL
);

COMMENT ON COLUMN "TB_PRODUCT_CATEGORY"."PDT_CATEG_NO" IS '상품 카테고리(옵션, 분류) 번호';

COMMENT ON COLUMN "TB_PRODUCT_CATEGORY"."PDT_CTEG" IS '주류 향수 구분 / 주류 : A , 향수 : F';

COMMENT ON COLUMN "TB_PRODUCT_CATEGORY"."PDT_FAMILY" IS '기성제품 커스텀제품 구분 / 기성제품:  B, 커스텀  : C';

COMMENT ON COLUMN "TB_PRODUCT_CATEGORY"."PDT_MANUFAC" IS '브랜드(제조자) 이름';

COMMENT ON COLUMN "TB_PRODUCT_CATEGORY"."PDT_GROUP" IS '제품군 분류 (퍼퓸, 오 드  뚜왈렛 | 맥주, 사케 등)';


CREATE TABLE "TB_PRODUCT_OPTION" (
	"PDT_OPTION_NO"	NUMBER		NOT NULL,
	"PDT_NO"	NUMBER		NOT NULL,
	"PDT_OPTION_FIRST"	VARCHAR2(100)		NOT NULL,
	"PDT_OPTION_SECOND"	VARCHAR2(100)		NULL
);

COMMENT ON COLUMN "TB_PRODUCT_OPTION"."PDT_OPTION_NO" IS '옵션 번호';

COMMENT ON COLUMN "TB_PRODUCT_OPTION"."PDT_NO" IS '상품 번호';

COMMENT ON COLUMN "TB_PRODUCT_OPTION"."PDT_OPTION_FIRST" IS '첫번째 옵션 (용량 ml / 중량)';

COMMENT ON COLUMN "TB_PRODUCT_OPTION"."PDT_OPTION_SECOND" IS '두번째 옵션 (도수 등 기타 옵션)';



CREATE TABLE "TB_PRODUCT_FILE" (
	"PDT_FILE_NO"	NUMBER		NOT NULL,
	"PDT_NO"	NUMBER		NOT NULL,
	"PDT_FILE_INDEX"	NUMBER		NULL,
	"PDT_FILE_PATH"	VARCHAR2(1000)		NOT NULL,
	"PDT_FILE_ORIGIN"	VARCHAR(255)		NOT NULL,
	"PDT_FILE_UPLOAD"	VARCHAR(255)		NOT NULL
);

COMMENT ON COLUMN "TB_PRODUCT_FILE"."PDT_FILE_NO" IS '상품 파일 번호';

COMMENT ON COLUMN "TB_PRODUCT_FILE"."PDT_NO" IS '상품 번호';

COMMENT ON COLUMN "TB_PRODUCT_FILE"."PDT_FILE_INDEX" IS '파일레벨 메인 : 0 , 나머지 : 1 이상';

COMMENT ON COLUMN "TB_PRODUCT_FILE"."PDT_FILE_PATH" IS '파일경로';

COMMENT ON COLUMN "TB_PRODUCT_FILE"."PDT_FILE_ORIGIN" IS '원본 파일명';

COMMENT ON COLUMN "TB_PRODUCT_FILE"."PDT_FILE_UPLOAD" IS '업로드 파일명';



CREATE TABLE "TB_ORDER_DETAIL" (
	"ORDER_DETAIL_NO"	NUMBER		NOT NULL,
	"ORDER_NO"	NUMBER		NOT NULL,
	"PDT_NO"	NUMBER		NOT NULL,
	"ORDER_PRICE"	NUMBER		NOT NULL,
	"ORDER_QUANTIRY"	NUMBER	DEFAULT 1	NULL,
	"Key"	VARCHAR(255)		NOT NULL
);

COMMENT ON COLUMN "TB_ORDER_DETAIL"."PDT_NO" IS '상품 번호';

COMMENT ON COLUMN "TB_ORDER_DETAIL"."ORDER_PRICE" IS '상품 주문 시 가격';


CREATE TABLE "TB_PAYMENT" (
	"Key"	VARCHAR(255)		NOT NULL,
	"Field"	VARCHAR(255)		NOT NULL,
	"Field2"	VARCHAR(255)	DEFAULT SYSDATE	NULL,
	"Field3"	VARCHAR(255)		NOT NULL,
	"Field4"	VARCHAR(255)	DEFAULT 'N'	NULL,
	"Field5"	VARCHAR(255)		NOT NULL,
	"Field6"	VARCHAR(255)		NOT NULL,
	"Field7"	VARCHAR(255)		NULL
);

COMMENT ON COLUMN "TB_PAYMENT"."Field" IS '무통장입금 / 신용카드 / 체크카드';

COMMENT ON COLUMN "TB_PAYMENT"."Field3" IS '정수';

COMMENT ON COLUMN "TB_PAYMENT"."Field7" IS '추가입금, 부분환불, 기타차액 등';


CREATE TABLE "TB_ORDER_COMPLAIN" (
	"ORDER_COMP_NO"	NUMBER		NOT NULL,
	"ORDER_NO"	NUMBER		NOT NULL,
	"ORDER_COMP_CATEG"	VARCHAR2(1)		NOT NULL,
	"ORDER_COMP_REASON"	VARCHAR(2000)		NOT NULL,
	"ORDER_COMP_STATUS"	VARCHAR2(1)	DEFAULT 'O'	NOT NULL,
	"ORDER_COMP_FILE_UPLOAD"	VARCHAR(255)		NULL,
	"ORDER_COMP_FILE_PATH"	VARCHAR2(1000)		NULL,
	"ORDER_COMP_DATE"	DATE		NOT NULL,
	"ORDER_COMP_CLOSE_DATE"	DATE		NULL
);

COMMENT ON COLUMN "TB_ORDER_COMPLAIN"."ORDER_NO" IS '주문 번호';

COMMENT ON COLUMN "TB_ORDER_COMPLAIN"."ORDER_COMP_CATEG" IS '환불1 / 교환2';

COMMENT ON COLUMN "TB_ORDER_COMPLAIN"."ORDER_COMP_REASON" IS '신청 사유';

COMMENT ON COLUMN "TB_ORDER_COMPLAIN"."ORDER_COMP_STATUS" IS '처리중: O, 승인 : Y, 반려 : N';

COMMENT ON COLUMN "TB_ORDER_COMPLAIN"."ORDER_COMP_FILE_UPLOAD" IS '사진파일 첨부(1개)';

COMMENT ON COLUMN "TB_ORDER_COMPLAIN"."ORDER_COMP_FILE_PATH" IS '파일 경로';

COMMENT ON COLUMN "TB_ORDER_COMPLAIN"."ORDER_COMP_DATE" IS '신청일';

COMMENT ON COLUMN "TB_ORDER_COMPLAIN"."ORDER_COMP_CLOSE_DATE" IS '처리 완료일';


CREATE TABLE "TB_RECEIVER" (
	"RECEIVER_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
	"RECEIVER_NAME"	VARCHAR2(20)		NOT NULL,
	"PHONE"	VARCHAR2(20)		NOT NULL,
	"ADDRESS"	VARCHAR2(200)		NOT NULL,
	"ADDRESS_DETAIL"	VARCHAR2(150)		NULL,
	"POSTAL_CODE"	NUMBER		NOT NULL,
	"PLACE_ALIAS"	VARCHAR2(20)		NULL,
	"PRIMARY_STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NULL
);

COMMENT ON COLUMN "TB_RECEIVER"."RECEIVER_NO" IS '배송정보 주소';

COMMENT ON COLUMN "TB_RECEIVER"."USER_NO" IS '회원번호';

COMMENT ON COLUMN "TB_RECEIVER"."RECEIVER_NAME" IS '받을사람 이름 (회원이름과 같을 시 본인주소)';

COMMENT ON COLUMN "TB_RECEIVER"."PHONE" IS '받을사람 전화번호(연락처, - 제외)';

COMMENT ON COLUMN "TB_RECEIVER"."ADDRESS" IS '받을사람 주소';

COMMENT ON COLUMN "TB_RECEIVER"."ADDRESS_DETAIL" IS '받을사람 상세주소(건물명, 호수 등)';

COMMENT ON COLUMN "TB_RECEIVER"."POSTAL_CODE" IS '받을사람 우편번호(5자리번호)';

COMMENT ON COLUMN "TB_RECEIVER"."PLACE_ALIAS" IS '배송지에 대한 별칭';

COMMENT ON COLUMN "TB_RECEIVER"."PRIMARY_STATUS" IS '기본배송지 구분 / 기본배송지 : Y, 기타배송지 :  N';


CREATE TABLE "TB_NOTICE" (
	"NOTICE_NO"	NUMBER		NOT NULL,
	"NOTICE_TITLE"	VARCHAR2(2000)		NOT NULL,
	"NOTICE_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"NOTICE_CREATE_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"NOTICE_FILE"	VARCHAR2(100)		NOT NULL,
	"NOTICE_COUNT"	NUMBER	DEFAULT 0	NULL,
	"NOTICE_STATE"	CHAR(1)	DEFAULT 'Y' CHECK(NOTICE_STATE IN ('Y','N'))	NULL
);

COMMENT ON COLUMN "TB_NOTICE"."NOTICE_NO" IS '공지 번호';

COMMENT ON COLUMN "TB_NOTICE"."NOTICE_TITLE" IS '공지 제목';

COMMENT ON COLUMN "TB_NOTICE"."NOTICE_CONTENT" IS '공지 내용';

COMMENT ON COLUMN "TB_NOTICE"."NOTICE_CREATE_DATE" IS '작성일';

COMMENT ON COLUMN "TB_NOTICE"."NOTICE_FILE" IS '첨부파일 이름';

COMMENT ON COLUMN "TB_NOTICE"."NOTICE_COUNT" IS '조회수';

COMMENT ON COLUMN "TB_NOTICE"."NOTICE_STATE" IS '활성여부';

/*
CREATE TABLE "TB_ORDER_UNLOGIN" (
	"ORDER_UN_NO"	NUMBER		NOT NULL,
	"ORDER_UN_PWD"	VARCHAR(255)		NOT NULL,
	"ORDER_UN_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"ORDER_UN_MESSAGE"	VARCHAR2(90)		NULL,
	"ORDER_UN_EST_DATE"	DATE		NULL,
	"ORDER_UN_ARRIV_DATE"	DATE		NULL,
	"Field"	VARCHAR2(20)		NOT NULL,
	"Field3"	VARCHAR2(20)		NOT NULL,
	"Field4"	VARCHAR2(60)		NOT NULL,
	"Field5"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "TB_ORDER_UNLOGIN"."ORDER_UN_NO" IS '비회원 주문 번호';

COMMENT ON COLUMN "TB_ORDER_UNLOGIN"."ORDER_UN_DATE" IS '주문일 YYYY-MM-DD';

COMMENT ON COLUMN "TB_ORDER_UNLOGIN"."ORDER_UN_EST_DATE" IS '도착 예상일';

COMMENT ON COLUMN "TB_ORDER_UNLOGIN"."ORDER_UN_ARRIV_DATE" IS '미배송 시 NULL';
*/

CREATE TABLE "TB_REVIEW_LIKE" (
	"USER_NO"	NUMBER		NOT NULL,
	"REVIEW_NO"	NUMBER		NOT NULL,
	"REVIEW_LIKE_FLAG"	CHAR(1)	DEFAULT 'L' CHECK(REVIEW_LIKE_FLAG IN ('L','D'))	NULL
);

COMMENT ON COLUMN "TB_REVIEW_LIKE"."REVIEW_NO" IS '리뷰 번호';

COMMENT ON COLUMN "TB_REVIEW_LIKE"."REVIEW_LIKE_FLAG" IS '추천/비추천';


CREATE TABLE "TB_BOARD_LIKE" (
	"USER_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL,
	"BOARD_LIKE_FLAG"	CHAR(1)	DEFAULT 'L' CHECK(BOARD_LIKE_FLAG IN ('L','D'))	NULL
);

COMMENT ON COLUMN "TB_BOARD_LIKE"."BOARD_NO" IS '게시판 번호';

COMMENT ON COLUMN "TB_BOARD_LIKE"."BOARD_LIKE_FLAG" IS '추천/비추천';


CREATE TABLE "TB_AUTH" (
	"AUTH_EMAIL"	VARCHAR2(50)		NOT NULL,
	"AUTH_CODE"	VARCHAR2(60)		NOT NULL,
	"AUTH_DATE"	DATE	DEFAULT SYSDATE	NOT NULL
);

COMMENT ON COLUMN "TB_AUTH"."AUTH_EMAIL" IS '이메일';

COMMENT ON COLUMN "TB_AUTH"."AUTH_CODE" IS '코드';

COMMENT ON COLUMN "TB_AUTH"."AUTH_DATE" IS '생성일';

ALTER TABLE "TB_PRODUCT" ADD CONSTRAINT "PK_TB_PRODUCT" PRIMARY KEY (
	"PDT_NO"
);

ALTER TABLE "TB_CART" ADD CONSTRAINT "PK_TB_CART" PRIMARY KEY (
	"CART_NO"
);

ALTER TABLE "TB_USER" ADD CONSTRAINT "PK_TB_USER" PRIMARY KEY (
	"USER_NO"
);

ALTER TABLE "TB_WISHLIST" ADD CONSTRAINT "PK_TB_WISHLIST" PRIMARY KEY (
	"PDT_NO",
	"USER_NO"
);

ALTER TABLE "TB_REVIEW" ADD CONSTRAINT "PK_TB_REVIEW" PRIMARY KEY (
	"REVIEW_NO"
);

ALTER TABLE "TB_BOARD" ADD CONSTRAINT "PK_TB_BOARD" PRIMARY KEY (
	"BOARD_NO"
);

ALTER TABLE "TB_COMMENT" ADD CONSTRAINT "PK_TB_COMMENT" PRIMARY KEY (
	"COMMENT_NO"
);

ALTER TABLE "TB_REVIEW_FILE" ADD CONSTRAINT "PK_TB_REVIEW_FILE" PRIMARY KEY (
	"REVIEW_FILE_NO"
);

ALTER TABLE "TB_BOARD_FILE" ADD CONSTRAINT "PK_TB_BOARD_FILE" PRIMARY KEY (
	"BOARD_FILE_NO"
);

ALTER TABLE "TB_BOARD_CTGY" ADD CONSTRAINT "PK_TB_BOARD_CTGY" PRIMARY KEY (
	"BOARD_CTGY_CODE"
);

ALTER TABLE "TB_FUNDING" ADD CONSTRAINT "PK_TB_FUNDING" PRIMARY KEY (
	"FUNDING_NO"
);

ALTER TABLE "TB_ORDER" ADD CONSTRAINT "PK_TB_ORDER" PRIMARY KEY (
	"ORDER_NO"
);

ALTER TABLE "TB_PRODUCT_CATEGORY" ADD CONSTRAINT "PK_TB_PRODUCT_CATEGORY" PRIMARY KEY (
	"PDT_CATEG_NO"
);

ALTER TABLE "TB_PRODUCT_OPTION" ADD CONSTRAINT "PK_TB_PRODUCT_OPTION" PRIMARY KEY (
	"PDT_OPTION_NO"
);

ALTER TABLE "TB_PRODUCT_FILE" ADD CONSTRAINT "PK_TB_PRODUCT_FILE" PRIMARY KEY (
	"PDT_FILE_NO"
);

ALTER TABLE "TB_ORDER_DETAIL" ADD CONSTRAINT "PK_TB_ORDER_DETAIL" PRIMARY KEY (
	"ORDER_DETAIL_NO"
);

ALTER TABLE "TB_PAYMENT" ADD CONSTRAINT "PK_TB_PAYMENT" PRIMARY KEY (
	"Key"
);

ALTER TABLE "TB_ORDER_COMPLAIN" ADD CONSTRAINT "PK_TB_ORDER_COMPLAIN" PRIMARY KEY (
	"ORDER_COMP_NO"
);

ALTER TABLE "TB_RECEIVER" ADD CONSTRAINT "PK_TB_RECEIVER" PRIMARY KEY (
	"RECEIVER_NO"
);

ALTER TABLE "TB_NOTICE" ADD CONSTRAINT "PK_TB_NOTICE" PRIMARY KEY (
	"NOTICE_NO"
);
/*
ALTER TABLE "TB_ORDER_UNLOGIN" ADD CONSTRAINT "PK_TB_ORDER_UNLOGIN" PRIMARY KEY (
	"ORDER_UN_NO"
);
*/
ALTER TABLE "TB_REVIEW_LIKE" ADD CONSTRAINT "PK_TB_REVIEW_LIKE" PRIMARY KEY (
	"USER_NO",
	"REVIEW_NO"
);

ALTER TABLE "TB_BOARD_LIKE" ADD CONSTRAINT "PK_TB_BOARD_LIKE" PRIMARY KEY (
	"USER_NO",
	"BOARD_NO"
);

ALTER TABLE "TB_AUTH" ADD CONSTRAINT "PK_TB_AUTH" PRIMARY KEY (
	"AUTH_EMAIL"
);

ALTER TABLE "TB_PRODUCT" ADD CONSTRAINT "FK_PRODUCT_CATEGORY_TO_PRODUCT" FOREIGN KEY (
	"PDT_CATEG_NO"
)
REFERENCES "TB_PRODUCT_CATEGORY" (
	"PDT_CATEG_NO"
);

ALTER TABLE "TB_CART" ADD CONSTRAINT "FK_USER_TO_CART" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "TB_USER" (
	"USER_NO"
);

ALTER TABLE "TB_CART" ADD CONSTRAINT "FK_PRODUCT_TO_CART" FOREIGN KEY (
	"PDT_NO"
)
REFERENCES "TB_PRODUCT" (
	"PDT_NO"
);

ALTER TABLE "TB_WISHLIST" ADD CONSTRAINT "FK_PRODUCT_TO_WISHLIST" FOREIGN KEY (
	"PDT_NO"
)
REFERENCES "TB_PRODUCT" (
	"PDT_NO"
);

ALTER TABLE "TB_WISHLIST" ADD CONSTRAINT "FK_USER_TO_WISHLIST" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "TB_USER" (
	"USER_NO"
);

ALTER TABLE "TB_REVIEW" ADD CONSTRAINT "FK_USER_TO_REVIEW" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "TB_USER" (
	"USER_NO"
);

ALTER TABLE "TB_REVIEW" ADD CONSTRAINT "FK_PRODUCT_TO_REVIEW" FOREIGN KEY (
	"PDT_NO"
)
REFERENCES "TB_PRODUCT" (
	"PDT_NO"
);

ALTER TABLE "TB_BOARD" ADD CONSTRAINT "FK_USER_TO_BOARD" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "TB_USER" (
	"USER_NO"
);

ALTER TABLE "TB_BOARD" ADD CONSTRAINT "FK_BOARD_CTGY_TO_BOARD" FOREIGN KEY (
	"BOARD_CTGY_CODE"
)
REFERENCES "TB_BOARD_CTGY" (
	"BOARD_CTGY_CODE"
);

ALTER TABLE "TB_COMMENT" ADD CONSTRAINT "FK_USER_TO_COMMENT" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "TB_USER" (
	"USER_NO"
);

ALTER TABLE "TB_COMMENT" ADD CONSTRAINT "FK_BOARD_TO_COMMENT" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "TB_BOARD" (
	"BOARD_NO"
);

ALTER TABLE "TB_COMMENT" ADD CONSTRAINT "FK_REVIEW_TO_COMMENT" FOREIGN KEY (
	"REVIEW_NO"
)
REFERENCES "TB_REVIEW" (
	"REVIEW_NO"
);

ALTER TABLE "TB_REVIEW_FILE" ADD CONSTRAINT "FK_REVIEW_TO_REVIEW_FILE" FOREIGN KEY (
	"REVIEW_NO"
)
REFERENCES "TB_REVIEW" (
	"REVIEW_NO"
);

ALTER TABLE "TB_BOARD_FILE" ADD CONSTRAINT "FK_BOARD_TO_BOARD_FILE" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "TB_BOARD" (
	"BOARD_NO"
);

ALTER TABLE "TB_FUNDING" ADD CONSTRAINT "FK_PRODUCT_TO_FUNDING" FOREIGN KEY (
	"PDT_NO"
)
REFERENCES "TB_PRODUCT" (
	"PDT_NO"
);

ALTER TABLE "TB_ORDER" ADD CONSTRAINT "FK_USER_TO_ORDER" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "TB_USER" (
	"USER_NO"
);

ALTER TABLE "TB_ORDER" ADD CONSTRAINT "FK_RECEIVER_TO_ORDER" FOREIGN KEY (
	"RECEIVER_NO"
)
REFERENCES "TB_RECEIVER" (
	"RECEIVER_NO"
);

ALTER TABLE "TB_PRODUCT_OPTION" ADD CONSTRAINT "FK_PRODUCT_TO_PRODUCT_OPTION" FOREIGN KEY (
	"PDT_NO"
)
REFERENCES "TB_PRODUCT" (
	"PDT_NO"
);

ALTER TABLE "TB_PRODUCT_FILE" ADD CONSTRAINT "FK_PRODUCT_TO_PRODUCT_FILE" FOREIGN KEY (
	"PDT_NO"
)
REFERENCES "TB_PRODUCT" (
	"PDT_NO"
);

ALTER TABLE "TB_ORDER_DETAIL" ADD CONSTRAINT "FK_ORDER_TO_ORDER_DETAIL" FOREIGN KEY (
	"ORDER_NO"
)
REFERENCES "TB_ORDER" (
	"ORDER_NO"
);

ALTER TABLE "TB_ORDER_DETAIL" ADD CONSTRAINT "FK_PRODUCT_TO_ORDER_DETAIL" FOREIGN KEY (
	"PDT_NO"
)
REFERENCES "TB_PRODUCT" (
	"PDT_NO"
);

ALTER TABLE "TB_ORDER_DETAIL" ADD CONSTRAINT "FK_PAYMENT_TO_ORDER_DETAIL" FOREIGN KEY (
	"Key"
)
REFERENCES "TB_PAYMENT" (
	"Key"
);

ALTER TABLE "TB_ORDER_COMPLAIN" ADD CONSTRAINT "FK_ORDER_TO_ORDER_COMPLAIN" FOREIGN KEY (
	"ORDER_NO"
)
REFERENCES "TB_ORDER" (
	"ORDER_NO"
);

ALTER TABLE "TB_RECEIVER" ADD CONSTRAINT "FK_USER_TO_RECEIVER" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "TB_USER" (
	"USER_NO"
);

ALTER TABLE "TB_REVIEW_LIKE" ADD CONSTRAINT "FK_USER_TO_REVIEW_LIKE" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "TB_USER" (
	"USER_NO"
);

ALTER TABLE "TB_REVIEW_LIKE" ADD CONSTRAINT "FK_REVIEW_TO_REVIEW_LIKE" FOREIGN KEY (
	"REVIEW_NO"
)
REFERENCES "TB_REVIEW" (
	"REVIEW_NO"
);

ALTER TABLE "TB_BOARD_LIKE" ADD CONSTRAINT "FK_USER_TO_BOARD_LIKE" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "TB_USER" (
	"USER_NO"
);

ALTER TABLE "TB_BOARD_LIKE" ADD CONSTRAINT "FK_BOARD_TO_BOARD_LIKE" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "TB_BOARD" (
	"BOARD_NO"
);

DROP SEQUENCE "SEQ_PAYMENT";
DROP SEQUENCE "SEQ_NOTICE";
DROP SEQUENCE "SEQ_ORDER_COMPLAIN";
DROP SEQUENCE "SEQ_COMMENT";
DROP SEQUENCE "SEQ_BOARD_FILE";
DROP SEQUENCE "SEQ_BOARD";
DROP SEQUENCE "SEQ_REVIEW";
DROP SEQUENCE "SEQ_REVIEW_FILE";
DROP SEQUENCE "SEQ_FUNDING";
DROP SEQUENCE "SEQ_PRODUCT_FILE";
DROP SEQUENCE "SEQ_ORDER_DETAIL";
DROP SEQUENCE "SEQ_PRODUCT_OPTION";
DROP SEQUENCE "SEQ_PRODUCT_CATEGORY";
DROP SEQUENCE "SEQ_ORDER";
DROP SEQUENCE "SEQ_WISHLIST";
DROP SEQUENCE "SEQ_CART";
DROP SEQUENCE "SEQ_RECEIVER";
DROP SEQUENCE "SEQ_PRODUCT";
DROP SEQUENCE "SEQ_USER";

CREATE SEQUENCE "SEQ_PAYMENT";
CREATE SEQUENCE "SEQ_NOTICE";
CREATE SEQUENCE "SEQ_ORDER_COMPLAIN";
CREATE SEQUENCE "SEQ_COMMENT";
CREATE SEQUENCE "SEQ_BOARD_FILE";
CREATE SEQUENCE "SEQ_BOARD";
CREATE SEQUENCE "SEQ_REVIEW";
CREATE SEQUENCE "SEQ_REVIEW_FILE";
CREATE SEQUENCE "SEQ_FUNDING";
CREATE SEQUENCE "SEQ_PRODUCT_FILE";
CREATE SEQUENCE "SEQ_ORDER_DETAIL";
CREATE SEQUENCE "SEQ_PRODUCT_OPTION";
CREATE SEQUENCE "SEQ_PRODUCT_CATEGORY";
CREATE SEQUENCE "SEQ_ORDER";
CREATE SEQUENCE "SEQ_WISHLIST";
CREATE SEQUENCE "SEQ_CART";
CREATE SEQUENCE "SEQ_RECEIVER";
CREATE SEQUENCE "SEQ_PRODUCT";
CREATE SEQUENCE "SEQ_USER";
