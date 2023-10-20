/**
 * MelodixAPI
 * Melodix API
 *
 * The version of the OpenAPI document: 1.0.0
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */

/*
 * MDCheckNickname_200_response.h
 *
 * 
 */

#ifndef MDCheckNickname_200_response_H
#define MDCheckNickname_200_response_H

#include <QJsonObject>

#include <QList>
#include <QString>

#include "MDEnum.h"
#include "MDObject.h"

namespace MelodixAPI {

class MDCheckNickname_200_response : public MDObject {
public:
    MDCheckNickname_200_response();
    MDCheckNickname_200_response(QString json);
    ~MDCheckNickname_200_response() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    QString getNickname() const;
    void setNickname(const QString &nickname);
    bool is_nickname_Set() const;
    bool is_nickname_Valid() const;

    QList<QString> getCandidateNicknames() const;
    void setCandidateNicknames(const QList<QString> &candidate_nicknames);
    bool is_candidate_nicknames_Set() const;
    bool is_candidate_nicknames_Valid() const;

    bool isDuplicated() const;
    void setDuplicated(const bool &duplicated);
    bool is_duplicated_Set() const;
    bool is_duplicated_Valid() const;

    qint32 getCode() const;
    void setCode(const qint32 &code);
    bool is_code_Set() const;
    bool is_code_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    QString m_nickname;
    bool m_nickname_isSet;
    bool m_nickname_isValid;

    QList<QString> m_candidate_nicknames;
    bool m_candidate_nicknames_isSet;
    bool m_candidate_nicknames_isValid;

    bool m_duplicated;
    bool m_duplicated_isSet;
    bool m_duplicated_isValid;

    qint32 m_code;
    bool m_code_isSet;
    bool m_code_isValid;
};

} // namespace MelodixAPI

Q_DECLARE_METATYPE(MelodixAPI::MDCheckNickname_200_response)

#endif // MDCheckNickname_200_response_H
